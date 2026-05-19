;;; init-defun.el --- Defined function by myself  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Defined function by myself
;;

;;; Code:

(defun defined/guess-derived-mode-prog-or-text-mode ()
  "Detect if the current major mode is derived from `prog-mode' or `text-mode'."
  (interactive)
  (message "Major mode is %s."
           (cond ((derived-mode-p 'prog-mode) "prog-mode")
                 ((derived-mode-p 'text-mode) "text-mode")
                 (t "neither prog-mode or text-mode"))))

(defun defined/guess-buffer-file-path ()
  "Echo current buffer file full path."
  (interactive)
  (message "%s" buffer-file-name))

(defalias 'defined/cape-dict-min (cape-capf-prefix-length #'cape-dict 4))

(defun defined/toggle-cape-dict-local ()
  "Toggle `cape-dict' completion in the current buffer.

If `cape-dict' is currently active in `completion-at-point-functions'
for this buffer, it will be removed. Otherwise, it will be added."
  (interactive)
  (let ((enabled (not (memq #'defined/cape-dict-min completion-at-point-functions))))
    (if enabled
        (add-hook 'completion-at-point-functions #'defined/cape-dict-min nil t)
      (remove-hook 'completion-at-point-functions #'defined/cape-dict-min t))
    (message "%s `cape-dict' completion in this buffer"
             (if enabled "Enable" "Disable"))))

(defun defined/get-auth-password (host)
  "Get password from auth-source for HOST.
Returns the password string if found, nil otherwise."
  (auth-info-password (car (auth-source-search :host host :max 1))))

(defun defined/guess-which-org-publish-project ()
  "Display and return the org-publish project name for the current Org file.
Returns the project name if found, nil otherwise."
  (interactive)
  (let ((filename (buffer-file-name)))
    (cond
     ((not filename)
      (message "Buffer is not visiting a file.")
      nil)

     ((not (string-match-p "\\.org\\'" filename))
      (message "This function only works with Org files.")
      nil)

     (t
      (let ((project (org-publish-get-project-from-filename filename)))
        (if project
            (let ((project-name (car project)))
              (message "Current Org file belongs to project: \"%s\"" project-name)
              project-name)
          (message "Current Org file does not belong to any org-publish project.")
          nil))))))


(defun defined/new-buffer (name)
  "Create and switch to a new empty buffer named NAME.

If NAME is empty or nil, auto-generate a unique name starting with `*new*'."
  (interactive
   (list (read-string "Buffer name (empty for *new*): ")))
  (let ((buffer-name (if (string-empty-p name)
                         (generate-new-buffer-name "*new*")
                       name)))
    (let ((buf (get-buffer-create buffer-name)))
      (switch-to-buffer buf)
      (setq buffer-read-only nil)
      (erase-buffer)
      (message "Created new buffer: %s" buffer-name))))

(global-set-key (kbd "C-x C-n") 'defined/new-buffer)

(provide 'init-defun)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-defun.el ends here
