(use-package neotree
    :init
    (bind-key "<f8>" 'neotree-toggle))

(use-package golden-ratio
    :init
    (setq golden-ratio-auto-scale t)
    :config
    (golden-ratio-mode 1))

(provide 'init-visual)