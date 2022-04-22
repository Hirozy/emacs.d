;;; init-projectile.el --- projectile configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; projectile configuration
;;

;;; Code:

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
  (projectile-mode 1))

(provide 'init-projectile)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-projectile.el ends here
