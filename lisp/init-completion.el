(require-packages '(company
                    yasnippet
                    yasnippet-snippets
                    smartparens))

(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(use-package company
    :init
    (progn
        (setq company-idle-delay 0.2
              company-minimum-prefix-length 1
              company-require-match nil
              company-dabbrev-ignore-case nil
              company-dabbrev-downcase nil)
        (add-hook 'after-init-hook 'global-company-mode)))
    ;; :bind
    ;;     (([tab] . company-complete-selection)))

(use-package yasnippet
    :commands (yas-global-mode yas-minor-mode)
    :init
    (add-hook 'prog-mode-hook #'yas-minor-mode)
    (add-hook 'org-mode-hook #'yas-minor-mode)
    (add-hook 'markdown-mode-hook #'yas-minor-mode))

(use-package smartparens-config
    :init
    ;; Always start smartparens mode in python-mode.
    (add-hook 'prog-mode-hook #'smartparens-mode))

(provide 'init-completion)
