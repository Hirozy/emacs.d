;;; init-theme.el --- Theme configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Theme configuration
;;

;;; Code:

(defcustom before-load-theme-hook nil
  "Functions to run before load theme."
  :type 'hook)

(defcustom after-load-theme-hook nil
  "Functions to run after load theme."
  :type 'hook)

(defun load-theme-hook-wrapper (origin-func theme &rest args)
  "A wrapper of hooks around `load-theme'."
  (mapc #'disable-theme custom-enabled-themes)
  (run-hook-with-args 'before-load-theme-hook theme)
  (apply origin-func theme args)
  (run-hook-with-args 'after-load-theme-hook theme))

(advice-add 'load-theme :around #'load-theme-hook-wrapper)

(add-hook 'after-load-theme-hook
          (lambda (theme)
            ;; After Emacs 27.1, custom theme faces are only available
            ;; if `custom--inhibit-theme-enable' is set to nil
            (let ((custom--inhibit-theme-enable nil))
              (when (equal 'leuven theme)
                (custom-theme-set-faces
                 'leuven
                 '(default ((t (:background "#FAFAFA"))))
                 '(hl-line ((t (:background "#E5E5E5")))))))))

(defvar current-default-theme nil
  "Current default theme.")

(defun swap-theme ()
  "Swap theme between `leuven' and `current-default-theme'"
  (interactive)
  (if current-default-theme
      (progn
        (load-theme current-default-theme)
        (setq current-default-theme nil))
    (progn
      (setq current-default-theme (car custom-enabled-themes))
      (load-theme 'leuven))))

(use-package color-theme-sanityinc-tomorrow
  :demand t
  :custom-face
  (cursor ((t (:background "#afafaf"))))
  :bind ("<f5>" . swap-theme)
  :config
  (load-theme 'sanityinc-tomorrow-eighties))

(provide 'init-theme)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-theme.el ends here
