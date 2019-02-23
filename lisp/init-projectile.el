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
  :bind-keymap
  (("s-p" . projectile-command-map)
   ("C-c p" . projectile-command-map))
  :config
  (setq projectile-indexing-method 'native)
  (projectile-mode 1)

  (use-package counsel-projectile
    :config
    (counsel-projectile-mode 1)))

(provide 'init-projectile)

;;; init-projectile.el ends here
