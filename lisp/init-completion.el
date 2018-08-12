(require-packages '(company
                    yasnippet
                    yasnippet-snippets
                    smartparens))

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

(setq tab-always-indent 'complete)

;; https://github.com/company-mode/company-mode/wiki/Switching-from-AC#setting-up-similar-popup-behavior
(defun my/company-visible-and-explicit-action-p ()
(and (company-tooltip-visible-p)
     (company-explicit-action-p)))

(defun company-ac-setup ()
    "Sets up `company-mode' to behave similarly to `auto-complete-mode'."
    (setq company-require-match nil)
    (setq company-auto-complete #'my/company-visible-and-explicit-action-p)
    (setq company-frontends '(company-echo-metadata-frontend
                              company-pseudo-tooltip-unless-just-one-frontend-with-delay
                              company-preview-frontend))
    (define-key company-active-map (kbd "<tab>")
        'company-select-next-if-tooltip-visible-or-complete-selection)
    (define-key company-active-map (kbd "TAB")
        'company-select-next-if-tooltip-visible-or-complete-selection))

(company-ac-setup)

;; disable company-mode for shell in Emacs
(add-hook 'shell-mode-hook (lambda () 
                            (company-mode -1))
                            'append)

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
