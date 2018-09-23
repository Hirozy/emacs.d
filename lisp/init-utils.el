(require-packages '(which-key
                    avy
                    magit
                    exec-path-from-shell))

(use-package which-key
  :init
  ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
  ;; zero might cause issues so a non-zero value is recommended.
  (setq which-key-idle-delay 0.1)
  :config
  (which-key-mode 1))

(use-package avy)

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))

(provide 'init-utils)
