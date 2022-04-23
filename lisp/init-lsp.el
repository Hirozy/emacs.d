;; init-lsp.el --- lsp mode configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Code:

(use-package lsp-mode
  :hook (((c-mode
           c++-mode
           objc-mode
           python-mode
           haskell-mode
           haskell-literate-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))

  :bind (("S-<f2>" . lsp-rename))

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

(use-package lsp-pyright
  :after (lsp-mode python-mode))

(use-package lsp-haskell
  :after (lsp-mode haskell-mode))

(provide 'init-lsp)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-lsp.el ends here
