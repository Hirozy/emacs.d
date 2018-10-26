(require-packages '(lsp-mode
                    lsp-ui
                    company-lsp))

(use-package lsp-mode
  :config
  (setq lsp-message-project-root-warning t)
  ;; https://github.com/cquery-project/emacs-cquery/issues/45#issuecomment-406813724
  (add-hook 'lsp-after-open-hook 'lsp-ui-mode))

(use-package lsp-ui
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-imenu
  :init
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

(provide 'init-lsp)
