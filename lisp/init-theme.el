;;; init-theme.el --- Theme configuration

;;; Commentary:
;;
;; Theme configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(solarized-theme))

;; (use-package color-theme-solarized
;;   :init
;;   ;; Set background to dark for color-theme-solarized
;;   (set-frame-parameter nil 'background-mode 'dark)
;;   (set-terminal-parameter nil 'background-mode 'dark))

(load-theme 'solarized-dark t)

(provide 'init-theme)

;;; init-theme.el ends here
