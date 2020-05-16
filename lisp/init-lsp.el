;;; init-lsp.el --- lsp mode configuration

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(eglot))

(use-package eglot
  :hook ((c-mode
          c++-mode
          objc-mode
          go-mode) . 'eglot-ensure)

  :config
  (setq eglot-server-programs
        '(((c++-mode c-mode objc-mode) . ("ccls"))
          (go-mode . ("go-langserver")))))

(provide 'init-lsp)

;;; init-lsp.el ends here
