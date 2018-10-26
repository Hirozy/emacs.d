(require-packages '(ivy
                    swiper
                    counsel
                    ivy-yasnippet
                    counsel-projectile))

(use-package ivy
  :bind
  ("M-x" . counsel-M-x)
  ("C-x b" . ivy-switch-buffer)
  :init
  (setq ivy-height 25
        ivy-use-virtual-buffers 1)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order)))
  ;; disable ivy prefixes
  (setq ivy-initial-inputs-alist nil)
  :config
  (ivy-mode 1))

(use-package swiper
  :bind
  ("C-s" . swiper))

(use-package counsel
  :bind
  ("C-x C-f" . counsel-find-file))

(provide 'init-ivy)
