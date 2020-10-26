;;; init-lsp.el --- lsp mode configuration

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(lsp-mode
                    lsp-ivy
                    lsp-treemacs
                    lsp-haskell
                    ccls
                    eglot
                    xref))

(use-package lsp-mode
  :hook (((c-mode
           c++-mode
           objc-mode
           go-mode
           haskell-mode
           haskell-literate-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (("C-c l" . counsel-flycheck))
  :commands lsp

  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        lsp-idle-delay 0.1)

  (use-package lsp-ivy
    :commands lsp-ivy-workspace-symbol)

  (use-package ccls
    :config
    (setq ccls-executable "ccls"))

  (use-package lsp-haskell
    :after haskell-mode))

(defun stay-out-of-mode-for-eglot ()
  "Run eglot without 'flymake-mode'."
  (flymake-mode -1))

(use-package eglot
  :hook ((python-mode) . eglot-ensure)

  :config
  (setq eglot-server-programs
        '((python-mode . ("pylance"))))
  (add-hook 'eglot-managed-mode-hook #'stay-out-of-mode-for-eglot))

(provide 'init-lsp)

;;; init-lsp.el ends here
