(require-packages '(neotree
                    golden-ratio
                    highlight-indent-guides
                    linum-relative))

(use-package neotree
  :init
  (bind-key "<f8>" 'neotree-toggle))

(use-package golden-ratio
  :init
  ;; https://github.com/emacs-helm/helm/issues/238#issuecomment-16490626
  (setq golden-ratio-exclude-buffer-names '("*helm M-x*" "*helm for files*"))
  ;; (setq golden-ratio-auto-scale t)
  :config
  (golden-ratio-mode 1))

(use-package highlight-indent-guides
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character
        ;; https://github.com/DarthFennec/highlight-indent-guides/issues/32#issuecomment-376587172
        highlight-indent-guides-auto-enabled nil))

(use-package linum-relative
  :init
  (setq linum-relative-backend 'display-line-numbers-mode)
  (linum-relative-global-mode 1))

(provide 'init-visual)
