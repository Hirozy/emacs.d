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
  :defer t
  :commands (magit-add-section-hook)
  :bind ("C-x m" . magit-status)
  :config
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules
                          'magit-insert-stashes
                          'append))

(use-package magit-lfs
  :after magit)

(provide 'init-git)

;;; init-git.el ends here
