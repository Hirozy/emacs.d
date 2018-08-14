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

;; https://github.com/company-mode/company-mode/wiki/Switching-from-AC
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

;; disable company-mode for shell in Emacs
(add-hook 'shell-mode-hook (lambda () 
                             (company-mode -1))
          'append)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package smartparens-config
  :init
  ;; Always start smartparens mode in python-mode.
  (add-hook 'prog-mode-hook #'smartparens-mode))

(provide 'init-completion)
