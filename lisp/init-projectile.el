;;; init-projectile.el --- projectile configuration

;;; Commentary:
;;
;; projectile configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(projectile))

(use-package projectile
  :bind-keymap (("s-p" . projectile-command-map)
                ("C-c p" . projectile-command-map)
                ("C-x p" . projectile-command-map))

  :defines (project-find-functions)
  :custom
  (projectile-show-menu nil)

  :config
  (setq projectile-enable-caching t
        projectile-indexing-method 'alien
        projectile-completion-system 'ivy)
  (projectile-mode 1))

(provide 'init-projectile)

;;; init-projectile.el ends here
