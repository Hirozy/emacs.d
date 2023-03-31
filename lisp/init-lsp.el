;; init-lsp.el --- lsp mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Code:

(use-package lsp-bridge
  :hook ((c-mode
          c++-mode
          objc-mode
          python-mode
          haskell-mode
          haskell-literate
          go-mode
          rust-mode) . (lambda ()
                         (corfu-mode -1)
                         (lsp-bridge-mode 1))))

(provide 'init-lsp)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-lsp.el ends here
