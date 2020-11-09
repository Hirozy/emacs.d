;;; init-lsp.el --- lsp mode configuration

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(eglot))

(defun defined/stay-out-of-mode-for-eglot ()
  "Run eglot without `flycheck-mode'."
  (flymake-mode -1))

(use-package eglot
  :hook ((c-mode
          c++-mode
          python-mode
          objc-mode
          go-mode
          haskell-mode
          haskell-literate-mode) . eglot-ensure)

  :config
  (setq eglot-server-programs
        '((python-mode . ("pylance"))
          ((c-mode c++-mode objc-mode) . ("ccls"))))
  (add-hook 'eglot-managed-mode-hook #'defined/stay-out-of-mode-for-eglot))

(provide 'init-lsp)

;;; init-lsp.el ends here
