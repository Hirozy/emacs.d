(use-package neotree
    :init
    (bind-key "<f8>" 'neotree-toggle))

(use-package golden-ratio
    :init
    ;; https://github.com/emacs-helm/helm/issues/238#issuecomment-16490626
    (setq  golden-ratio-exclude-buffer-names '("*helm M-x*" "*helm for files*"))
    ;; (setq golden-ratio-auto-scale t)
    :config
    (golden-ratio-mode 1))

(provide 'init-visual)