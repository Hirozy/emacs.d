;; init-lsp.el --- lsp mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Code:

(require 'cape)

(defun cape-capf-at-eglot ()
  "Configure completion-at-point functions based on major mode.
For C/C++/Objective-C modes, combine eglot and citre completions.
For other modes, use eglot completion only.
Includes template expansion and file path completion in all cases.
The function is described at
https://github.com/minad/corfu/wiki#making-a-cape-super-capf-for-eglot"
  (if (member major-mode '(c-mode c++-mode objc-mode))
      (setq-local completion-at-point-functions
                  (list #'tempel-expand
                        #'cape-file
                        (cape-capf-super #'eglot-completion-at-point #'citre-completion-at-point)))
    (setq-local completion-at-point-functions
                (list #'tempel-expand
                      #'cape-file
                      #'eglot-completion-at-point))))

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
  :hook ((c-mode
          c-ts-mode
          c++-mode c++-ts-mode objc-mode
          python-mode python-ts-mode
          haskell-mode
          haskell-literate-mode
          go-mode go-ts-mode)
         . eglot-ensure)
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
