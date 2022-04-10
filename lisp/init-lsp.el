;; init-lsp.el --- lsp mode configuration

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(lsp-mode
                    lsp-haskell
                    lsp-pyright))


(use-package lsp-mode
  :hook (((c-mode
           c++-mode
           objc-mode
           python-mode
           haskell-mode
           haskell-literate-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-completion-mode . (lambda ()
                                  (setq-local company-backends
                                              '((company-capf :with company-dabbrev-code)
                                                company-files
                                                company-yasnippet)))))
  :bind (("C-c l" . counsel-flycheck)
         ("S-<f2>" . lsp-rename))

  :custom
  ;; Prevent lsp from automatically adding company-capf
  (lsp-completion-provider :none)
  (lsp-clients-clangd-args
   '("--header-insertion-decorators=0" "--header-insertion=never" "--clang-tidy"))

  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        lsp-idle-delay 0.1
        lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ivy
  :after (lsp-mode ivy)
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-pyright
  :after (lsp-mode python-mode))

(use-package lsp-haskell
  :after (lsp-mode haskell-mode))

(provide 'init-lsp)

;;; init-lsp.el ends here
