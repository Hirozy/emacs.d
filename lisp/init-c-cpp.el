(require-packages '(lsp-mode
                    cquery
                    smartparens))

(setq c-basic-offset 4)

(use-package smartparens-config
    :init
    ;; Always start smartparens mode in python-mode.
    (add-hook 'c-mode-hook #'smartparens-mode)
    (add-hook 'c++-mode-hook #'smartparens-mode))

(setq cquery-path (concat dotfiles-dir "site-lisp/package/cquery/build/cquery"))

(use-package cquery
    :commands lsp-cquery-enable
    :init
    (setq cquery-executable cquery-path)
    (setq cquery-cache-dir "/tmp/")
    (add-hook 'c-mode-hook 'lsp-cquery-enable)
    (add-hook 'c++-mode-hook 'lsp-cquery-enable)
    ;; https://github.com/cquery-project/emacs-cquery/issues/45#issuecomment-406813724
    (add-hook 'lsp-after-open-hook 'lsp-ui-mode))

(provide 'init-c-cpp)
