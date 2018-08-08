(require 'init-company)
(require 'anaconda-mode)
(require 'company-anaconda)
(require 'rx)

;; anaconda-mode, company-anacona, ein, smartparens

;; Always start smartparens mode in python-mode.
(require 'smartparens-config)
(add-hook 'python-mode-hook #'smartparens-mode)

;; Enable anaconda-mode hook
(add-hook 'python-mode-hook 'anaconda-mode)

;; Change backgends to company-anaconda
(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))

;; Use ipython instead of Python C-x C-p
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(provide 'init-python)