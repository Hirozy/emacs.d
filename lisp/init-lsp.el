;; init-lsp.el --- lsp mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Code:

(defun cape-capf-at-eglot ()
  (setq-local completion-at-point-functions
              '(tempel-expand
                cape-file
                cape-dabbrev
                eglot-completion-at-point)))

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
              ("S-<f6>" . eglot-rename))

  :init
  ;; disable lsp server event buffer
  (setq eglot-events-buffer-size 0)
  (advice-add 'jsonrpc--log-event :around
              (lambda (_orig-func &rest _)))

  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        eglot-stay-out-of '(company))

  (add-to-list 'eglot-server-programs '((objc-mode) "clangd"))

  (with-eval-after-load 'eglot
    (setq completion-category-defaults nil))

  (add-hook 'eglot-managed-mode-hook #'cape-capf-at-eglot))

(provide 'init-lsp)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-lsp.el ends here
