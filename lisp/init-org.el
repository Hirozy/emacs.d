;;; init-org.el --- org mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; org mode configuration
;;

;;; Code:
(require 'cl-lib)
(require 'transient)
(require 'consult)

(defvar defined/yank-media-image-from-formats
  '(image/bmp
    image/jpeg
    image/webp
    image/tiff)
  "MIME types that need to be converted to PNG.")

(defun defined/yank-media--get-clipboard-command ()
  "Return the clipboard command template based on the current window system.
Returns a cons cell (COMMAND . EXECUTABLES) or nil if unsupported."
  (pcase window-system
    ('pgtk
     '("wl-paste -t %s | convert - png:- | wl-copy -o -t image/png"
       . ("wl-paste" "wl-copy" "convert")))
    ('x
     '("xclip -selection clipboard -t %s -o | convert - png:- | xclip -selection clipboard -t image/png -i"
       . ("xclip" "convert")))
    (_ nil)))

(defun defined/yank-media--check-executables (executables)
  "Check if all EXECUTABLES are available in PATH.
Returns the first missing executable or nil if all are found."
  (cl-find-if-not #'executable-find executables))

(defun defined/yank-media-ensure-png-image (&rest _)
  "Convert the image in clipboard to image/png format.

Supported window systems:
- Wayland (pgtk): requires 'wl-clipboard' and 'ImageMagick'
- X11: requires 'xclip' and 'ImageMagick'"
  (let ((cmd-info (defined/yank-media--get-clipboard-command)))
    (cond
     ((null cmd-info)
      (message "Unsupported window system: %s (only pgtk and x are supported)"
               window-system))
     ((when-let ((missing (defined/yank-media--check-executables (cdr cmd-info))))
        (message "Required executable not found: %s" missing)
        t))
     (t
      (let ((targets (gui-backend-get-selection 'CLIPBOARD 'TARGETS))
            (command-template (car cmd-info)))
        (cond
         ((null targets)
          (message "No content in clipboard"))
         ((memq 'image/png (append targets nil))
          (message "Clipboard already contains image/png"))
         (t
          (let ((converted nil))
            (cl-dolist (type defined/yank-media-image-from-formats)
              (when (memq type (append targets nil))
                (let* ((typestr (symbol-name type))
                       (command (format command-template typestr)))
                  (if (zerop (call-process-shell-command command nil nil nil))
                      (progn
                        (message "Converted image from `%s' to `image/png'." typestr)
                        (setq converted t))
                    (message "Failed to convert image from `%s'." typestr)))
                (cl-return nil)))
            (unless converted
              (message "No convertible image format found in clipboard"))))))))))

(defvar defined/org-without-confirm-babel
  '("dot"
    "gnuplot"
    "python"
    "plantuml"
    )
  "List of languages that should not prompt for confirmation when evaluating.")

(use-package org
  :defer t
  :hook ((org-mode . visual-line-mode)
         (org-mode . eldoc-mode)
         (org-mode . (lambda ()
                       (setq-local lsp-diagnostics-provider :none))))
  :bind (:map org-mode-map
              ("C-," . org-mark-ring-goto))

  :custom
  (org-support-shift-select t)
  (org-startup-with-inline-images t) ;; always display inline images
  (org-src-fontify-natively t)  ;; fontify code in code blocks
  (org-src-preserve-indentation t)  ;;  source code is aligned with the leftmost column
  (org-export-with-sub-superscripts nil)
  (org-confirm-babel-evaluate (lambda (lang body)
                                (not (member lang defined/org-without-confirm-babel))))

  :config
  ;; https://orgmode.org/worg/org-contrib/babel/languages.html
  ;; https://orgmode.org/manual/Languages.html#Languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (R . t)
     (awk . t)
     (calc . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (haskell . t)
     (latex . t)
     (lisp . t)
     (lua . t)
     (matlab . t)
     (octave . t)
     (org . t)
     (perl . t)
     (python . t)
     (plantuml . t)
     (ruby . t)
     (sed . t)
     (sql . t)
     (table . t)))

  (when (memq window-system '(x pgtk))
    (advice-add 'yank-media :before #'defined/yank-media-ensure-png-image)))

(use-package ob-core
  :after org
  :hook (org-babel-after-execute . org-redisplay-inline-images))

(use-package ob-plantuml
  :after org
  :custom
  (org-plantuml-exec-mode 'plantuml))

(use-package org-shell-cat
  :after org
  :commands org-copy-to-shell-cat
  :hook (org-mode . org-babel-header-expand-shell-cat)
  :bind (:map org-mode-map
              ("C-c c" . org-copy-to-shell-cat)))

(use-package denote
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c d" . denote-open-or-create-with-command))
  :config
  (denote-rename-buffer-mode))

(use-package consult-denote
  :after denote
  :custom
  (consult-denote-grep-command #'consult-ripgrep)
  (consult-denote-find-command #'consult-fd)
  :config
  (consult-denote-mode))

(provide 'init-org)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-org.el ends here
