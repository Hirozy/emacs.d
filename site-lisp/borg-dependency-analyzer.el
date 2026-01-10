;;; borg-dependency-analyzer.el --- Analyze borg package dependencies -*- lexical-binding: t -*-

(require 'borg)
(require 'package)

;;; --- Core Functions ---

(defun borg-deps--get-package-requires (pkg-name)
  "Get the Package-Requires for a borg package PKG-NAME."
  (let* ((pkg-dir (borg-worktree pkg-name))
         (main-file (expand-file-name (concat pkg-name ".el") pkg-dir)))
    (when (file-exists-p main-file)
      (with-temp-buffer
        (insert-file-contents main-file)
        (goto-char (point-min))
        (when (re-search-forward "^;; Package-Requires: \\(.*\\)$" nil t)
          (condition-case nil
              (car (read-from-string (match-string 1)))
            (error nil)))))))

(defun borg-deps--build-dependency-graph ()
  "Build a hash table of package -> dependencies."
  (let ((graph (make-hash-table :test 'equal))
        (clones (borg-clones)))
    (dolist (pkg clones)
      (let ((deps (borg-deps--get-package-requires pkg)))
        (puthash pkg (mapcar (lambda (dep)
                               (if (listp dep) (symbol-name (car dep))
                                 (symbol-name dep)))
                             deps)
                 graph)))
    graph))

(defun borg-deps--build-reverse-dependency-graph (graph)
  "Build reverse dependency graph (who depends on whom)."
  (let ((reverse-graph (make-hash-table :test 'equal)))
    (maphash (lambda (pkg deps)
               (dolist (dep deps)
                 (puthash dep
                          (cons pkg (gethash dep reverse-graph))
                          reverse-graph)))
             graph)
    reverse-graph))

;;; --- Analysis Functions ---

(defun borg-deps-list-all ()
  "List all borg packages with their dependencies."
  (interactive)
  (let ((graph (borg-deps--build-dependency-graph))
        (buf (get-buffer-create "*Borg Dependencies*")))
    (with-current-buffer buf
      (erase-buffer)
      (insert "=== Borg Package Dependencies ===\n\n")
      (maphash (lambda (pkg deps)
                 (insert (format "* %s\n" pkg))
                 (if deps
                     (dolist (dep deps)
                       (insert (format "   └─ %s\n" dep)))
                   (insert "   (no dependencies)\n"))
                 (insert "\n"))
               graph)
      (goto-char (point-min)))
    (switch-to-buffer buf)))

(defun borg-deps-find-leaf-packages ()
  "Find packages that nothing else depends on (candidates for removal)."
  (interactive)
  (let* ((graph (borg-deps--build-dependency-graph))
         (reverse-graph (borg-deps--build-reverse-dependency-graph graph))
         (clones (borg-clones))
         (leaves '())
         (buf (get-buffer-create "*Borg Leaf Packages*")))
    ;; Find packages with no reverse dependencies
    (dolist (pkg clones)
      (unless (gethash pkg reverse-graph)
        (push pkg leaves)))
    (with-current-buffer buf
      (erase-buffer)
      (insert "=== Leaf Packages (nothing depends on them) ===\n")
      (insert "These are potential candidates for removal:\n\n")
      (dolist (pkg (sort leaves #'string<))
        (insert (format "  • %s\n" pkg)))
      (insert (format "\nTotal: %d leaf packages out of %d\n"
                      (length leaves) (length clones)))
      (goto-char (point-min)))
    (switch-to-buffer buf)))

(defun borg-deps-who-depends-on (pkg-name)
  "Show which packages depend on PKG-NAME."
  (interactive
   (list (completing-read "Package: " (borg-clones))))
  (let* ((graph (borg-deps--build-dependency-graph))
         (reverse-graph (borg-deps--build-reverse-dependency-graph graph))
         (dependents (gethash pkg-name reverse-graph))
         (buf (get-buffer-create "*Borg Dependents*")))
    (with-current-buffer buf
      (erase-buffer)
      (insert (format "=== Packages that depend on '%s' ===\n\n" pkg-name))
      (if dependents
          (dolist (dep (sort dependents #'string<))
            (insert (format "  • %s\n" dep)))
        (insert "  (none - safe to remove)\n"))
      (goto-char (point-min)))
    (switch-to-buffer buf)))

(defun borg-deps-dependency-tree (pkg-name &optional depth)
  "Show full dependency tree for PKG-NAME."
  (interactive
   (list (completing-read "Package: " (borg-clones))))
  (let ((graph (borg-deps--build-dependency-graph))
        (visited (make-hash-table :test 'equal))
        (buf (get-buffer-create "*Borg Dependency Tree*")))
    (cl-labels ((show-tree (pkg level)
                  (unless (gethash pkg visited)
                    (puthash pkg t visited)
                    (insert (make-string (* level 2) ?\s))
                    (insert (if (> level 0) "└─ " ""))
                    (insert pkg "\n")
                    (dolist (dep (gethash pkg graph))
                      (show-tree dep (1+ level))))))
      (with-current-buffer buf
        (erase-buffer)
        (insert (format "=== Dependency Tree for '%s' ===\n\n" pkg-name))
        (show-tree pkg-name 0)
        (goto-char (point-min))))
    (switch-to-buffer buf)))

;;; --- Orphan Detection ---

(defun borg-deps-find-orphaned-deps ()
  "Find dependencies that are installed but not required by any installed package."
  (interactive)
  (let* ((graph (borg-deps--build-dependency-graph))
         (clones (borg-clones))
         (all-deps (make-hash-table :test 'equal))
         (orphans '())
         (buf (get-buffer-create "*Borg Orphaned Dependencies*")))
    ;; Collect all declared dependencies
    (maphash (lambda (_pkg deps)
               (dolist (dep deps)
                 (puthash dep t all-deps)))
             graph)
    ;; Find installed packages that are dependencies but whose dependents
    ;; might not actually need them anymore
    (dolist (pkg clones)
      (let ((deps (gethash pkg graph)))
        (when (and (not (gethash pkg all-deps))  ; Not a dependency of others
                   (null deps))                   ; Has no dependencies itself
          (push pkg orphans))))
    (with-current-buffer buf
      (erase-buffer)
      (insert "=== Potentially Orphaned Packages ===\n")
      (insert "(Standalone packages that nothing depends on)\n\n")
      (dolist (pkg (sort orphans #'string<))
        (insert (format "  • %s\n" pkg)))
      (goto-char (point-min)))
    (switch-to-buffer buf)))

;;; --- Summary Report ---

(defun borg-deps-summary ()
  "Generate a comprehensive dependency summary."
  (interactive)
  (let* ((graph (borg-deps--build-dependency-graph))
         (reverse-graph (borg-deps--build-reverse-dependency-graph graph))
         (clones (borg-clones))
         (buf (get-buffer-create "*Borg Dependency Summary*"))
         (most-depended '())
         (most-deps '()))
    ;; Calculate stats
    (maphash (lambda (pkg deps)
               (push (cons pkg (length deps)) most-deps))
             graph)
    (maphash (lambda (pkg dependents)
               (push (cons pkg (length dependents)) most-depended))
             reverse-graph)
    (with-current-buffer buf
      (erase-buffer)
      (insert "╔══════════════════════════════════════════╗\n")
      (insert "║     BORG DEPENDENCY ANALYSIS REPORT      ║\n")
      (insert "╚══════════════════════════════════════════╝\n\n")

      (insert (format "Total packages: %d\n\n" (length clones)))

      (insert "Most depended upon (core packages):\n")
      (dolist (item (seq-take (sort most-depended
                                    (lambda (a b) (> (cdr a) (cdr b))))
                              10))
        (insert (format "   %s (%d dependents)\n" (car item) (cdr item))))

      (insert "\nPackages with most dependencies:\n")
      (dolist (item (seq-take (sort most-deps
                                    (lambda (a b) (> (cdr a) (cdr b))))
                              10))
        (when (> (cdr item) 0)
          (insert (format "   %s (%d deps)\n" (car item) (cdr item)))))

      (goto-char (point-min)))
    (switch-to-buffer buf)))

(provide 'borg-dependency-analyzer)
