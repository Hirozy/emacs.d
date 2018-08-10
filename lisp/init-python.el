(require-packages '(smartparens
                    ein))

(use-package rx)
(use-package init-completion)

(setq python-completion-mode-value "lsp")

;; Use ipython instead of Python
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i --simple-prompt"
    python-shell-completion-native-enable nil)

(use-package smartparens-config
    :init
    ;; Always start smartparens mode in python-mode.
    (add-hook 'python-mode-hook #'smartparens-mode))

(defun python-completion-mode/anaconda ()
    (require-packages '(anaconda-mode
                        company-anaconda))

    (use-package anaconda-mode
        :init
        ;; Enable anaconda-mode hook
        (add-hook 'python-mode-hook 'anaconda-mode))

    (use-package company-anaconda
        :init
        ;; Change backgends to company-anaconda
        (eval-after-load "company"
             '(add-to-list 'company-backends 'company-anaconda))))

(defun python-completion-mode/elpy ()
    (require-packages '(elpy))

    (use-package elpy
        :init
        (elpy-enable 1)))

(defun python-completion-mode/lsp ()
    (require-packages '(lsp-mode
                        lsp-ui
                        company-lsp))

    (use-package lsp-mode
        :config
        (setq lsp-message-project-root-warning t)
        (add-hook 'python-mode-hook
            (lambda ()
              (lsp-python-enable)))
        (lsp-define-stdio-client lsp-python "python"
			 (lsp-make-traverser #'(lambda (dir)
						 (directory-files
						  dir
						  nil
						  "\\(__init__\\|setup\\)\\.py\\|Pipfile")))
			 '("pyls")))

    (use-package lsp-imenu
        :init
        (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))
    
    (use-package lsp-ui
        :init
        (add-hook 'lsp-mode-hook 'lsp-ui-mode)
        (add-hook 'python-mode-hook 'flycheck-mode))
        
    (use-package company-lsp
        :config
        (push 'company-lsp company-backends)))

(cond ((string= python-completion-mode-value "anaconda")
          (funcall 'python-completion-mode/anaconda))
      ((string= python-completion-mode-value "elpy")
          (funcall 'python-completion-mode/elpy))
      ((string= python-completion-mode-value "lsp")
          (funcall 'python-completion-mode/lsp)))

(provide 'init-python)