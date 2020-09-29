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
                    lsp-pyright
                    ccls
                    xref))

(use-package lsp-mode
  :hook (((c-mode
           c++-mode
           objc-mode
           go-mode
           python-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (("C-c l" . counsel-flycheck))
  :commands lsp

  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        lsp-completion-provider :capf
        lsp-idle-delay 0.1)
  (use-package lsp-pyright
    :hook (python-mode . (lambda ()
                           (require 'lsp-pyright)
                           (lsp))))

  (use-package lsp-ivy
    :commands lsp-ivy-workspace-symbol)

  (use-package ccls
    :config
    (setq ccls-executable "ccls")))


(provide 'init-lsp)

;;; init-lsp.el ends here
