;; init-lsp.el --- lsp mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Code:

(use-package eglot
  :commands (eglot-ensure eglot)
  :custom
  (eglot-ignored-server-capabilities
   '(:documentHighlightProvider
     :codeLensProvider
     :documentOnTypeFormattingProvider
     :documentLinkProvider
     :colorProvider
     :foldingRangeProvider
     :executeCommandProvider))
  :hook (((c-mode
           c++-mode
           objc-mode
           python-mode
           haskell-mode
           haskell-literate-mode
           go-mode
           rust-mode) . eglot-ensure))
  :bind (:map eglot-mode-map
              ("S-<f2>" . eglot-rename))

  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        eglot-stay-out-of '(company))

  (add-to-list 'eglot-server-programs '((objc-mode) "clangd")))

(provide 'init-lsp)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-lsp.el ends here
