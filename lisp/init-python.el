(use-package rx)
(use-package init-completion)

;; Use ipython instead of Python
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i --simple-prompt")

(use-package smartparens-config
    :init
    ;; Always start smartparens mode in python-mode.
    (add-hook 'python-mode-hook #'smartparens-mode))

(use-package anaconda-mode
    :init
    ;; Enable anaconda-mode hook
    (add-hook 'python-mode-hook 'anaconda-mode))

(use-package company-anaconda
    :init
    ;; Change backgends to company-anaconda
    (eval-after-load "company"
      '(add-to-list 'company-backends 'company-anaconda)))

(provide 'init-python)