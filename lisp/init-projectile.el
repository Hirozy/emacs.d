;;; init-projectile.el --- projectile configuration

;;; Commentary:
;;
;; projectile configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(projectile
                    counsel-projectile))

(use-package projectile
  :bind-keymap (("s-p" . projectile-command-map)
                ("C-c p" . projectile-command-map)
                ("C-x p" . projectile-command-map))

  :custom
  (projectile-show-menu nil)
  :init
  (defun defined/projectile-project-find-function (dir)
    (let ((root (projectile-project-root dir)))
      (and root (cons 'transient root))))

  :config
  (setq projectile-enable-caching t
        projectile-indexing-method 'alien
        projectile-completion-system 'ivy)

  (with-eval-after-load 'project
    (add-to-list 'project-find-functions
                 #'defined/projectile-project-find-function))

  (projectile-mode 1)

  (use-package counsel-projectile
    :config
    (counsel-projectile-mode 1)))

(provide 'init-projectile)

;;; init-projectile.el ends here
