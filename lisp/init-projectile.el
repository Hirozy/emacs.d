;;; init-projectile.el --- projectile configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; projectile configuration
;;

;;; Code:

(use-package projectile
  :demand
  :bind-keymap (("s-p" . projectile-command-map)
                ("C-c p" . projectile-command-map))
  :bind (:map projectile-command-map
              ("s" . projectile-ripgrep))

  :defines (project-find-functions)
  :custom
  (projectile-show-menu nil)

  :config
  (setq projectile-enable-caching 'persistent
        projectile-indexing-method 'alien)
  (projectile-mode))

(provide 'init-projectile)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-projectile.el ends here
