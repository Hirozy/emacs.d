;;; init-projectile.el --- projectile configuration

;;; Commentary:
;;
;; projectile configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(projectile))

(defun defined/projectile-project-find-function (dir)
  "Projectile find DIR function."
  (let ((root (projectile-project-root dir)))
    (and root (cons 'transient root))))

(use-package projectile
  :bind-keymap (("s-p" . projectile-command-map)
                ("C-c p" . projectile-command-map)
                ("C-x p" . projectile-command-map))

  :defines (project-find-functions)
  :custom
  (projectile-show-menu nil)

  :config
  (setq projectile-enable-caching t
        projectile-indexing-method 'alien)

  (with-eval-after-load 'project
    (add-to-list 'project-find-functions
                 #'defined/projectile-project-find-function))

  (projectile-mode 1))

(provide 'init-projectile)

;;; init-projectile.el ends here
