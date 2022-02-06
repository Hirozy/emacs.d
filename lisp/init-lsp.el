;; init-lsp.el --- lsp mode configuration

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(lsp-mode
                    lsp-ivy
                    lsp-haskell
                    lsp-pyright))

(use-package lsp-mode
  :hook (((c-mode
           c++-mode
           python-mode
           haskell-mode
           haskell-literate-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (("C-c l" . counsel-flycheck)
         ("S-<f2>" . lsp-rename))

  :custom
  (lsp-clients-clangd-args
   '("--header-insertion-decorators=0" "--header-insertion=never" "--clang-tidy"))

  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        lsp-idle-delay 0.1
        lsp-headerline-breadcrumb-enable nil)

  (use-package lsp-ivy
    :commands lsp-ivy-workspace-symbol)

  (use-package lsp-pyright
    :hook (python-mode . (lambda ()
                           (require 'lsp-pyright)
                           (lsp))))

  (use-package lsp-haskell
    :after haskell-mode))

(provide 'init-lsp)

;;; init-lsp.el ends here
