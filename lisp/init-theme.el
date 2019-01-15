;;; init-theme.el --- Theme configuration

;;; Commentary:
;;
;; Theme configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(solarized-theme))

(load-theme 'solarized-dark t)

(provide 'init-theme)

;;; init-theme.el ends here
