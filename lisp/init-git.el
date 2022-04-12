;;; init-git.el --- Git tools configuration

;;; Commentary:
;;
;; Git tools configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(magit
                    transient
                    magit-lfs))

(use-package magit
  :bind ("C-x m" . magit-status))

(use-package magit-lfs
  :after magit)

(provide 'init-git)

;;; init-git.el ends here
