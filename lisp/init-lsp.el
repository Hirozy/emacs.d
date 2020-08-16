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
          go-mode
          python-mode) . 'eglot-ensure)

  :init
  (defun stay-out-of-mode-for-eglot ()
    (flymake-mode -1)
    (eldoc-mode -1))

  :config
  (setq eglot-server-programs
        '(((c++-mode c-mode objc-mode) . ("ccls"))
          (go-mode . ("go-langserver"))
          (python-mode . ("pylance"))))
  (add-hook 'eglot-managed-mode-hook 'stay-out-of-mode-for-eglot))

(provide 'init-lsp)

;;; init-lsp.el ends here
