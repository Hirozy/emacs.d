;;; init-theme.el --- Theme configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Theme configuration
;;

;;; Code:

(defcustom load-theme-before-hook nil
  "Functions to run before load theme."
  :type 'hook)

(defcustom load-theme-after-hook nil
  "Functions to run after load theme."
  :type 'hook)

(defun load-theme-hook-wrapper (origin-func theme &rest args)
  "A wrapper of hooks around `load-theme'."
  (mapc #'disable-theme custom-enabled-themes)
  (run-hook-with-args 'load-theme-before-hook theme)
  (apply origin-func theme args)
  (run-hook-with-args 'load-theme-after-hook theme))

(advice-add 'load-theme :around #'load-theme-hook-wrapper)

(use-package color-theme-sanityinc-tomorrow
  :custom-face
  (cursor ((t (:background "#afafaf"))))
  :config
  (load-theme 'sanityinc-tomorrow-eighties))

(provide 'init-theme)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-theme.el ends here
