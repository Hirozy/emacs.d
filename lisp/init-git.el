;;; init-git.el --- Git tools configuration

;;; Commentary:
;;
;; Git tools configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(magit
                    transient))

(use-package magit
  :bind ("C-x m" . magit-status))

(provide 'init-git)

;;; init-git.el ends here
