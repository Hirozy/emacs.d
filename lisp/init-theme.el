;;; init-theme.el --- Theme configuration

;;; Commentary:
;;
;; Theme configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(solarized-theme
                    spacemacs-theme))

(load-theme 'spacemacs-dark)

(provide 'init-theme)

;;; init-theme.el ends here
