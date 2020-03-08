;;; init-lsp.el --- lsp mode configuration

;;; Commentary:
;;
;; lsp mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(lsp-mode
                    lsp-ui
                    company-lsp
                    lsp-ivy))

(use-package lsp-mode
  :hook (((c-mode c++-mode objc-mode go-mode) .
          (lambda ()
            (lsp)
            (set (make-local-variable 'company-backends)
                 '(company-lsp company-yasnippet))))
         (lsp-mode . lsp-enable-which-key-integration))
  :bind ("s-l" . lsp-keymap-prefix)

  :config
  (setq-default company-lsp-enable-snippet t
                lsp-enable-snippet t)

  (use-package lsp-ui
    ;; https://github.com/cquery-project/emacs-cquery/issues/45
    :hook (lsp-after-open . lsp-ui-mode))

  (use-package lsp-ivy
    :commands lsp-ivy-workspace-symbol))

(provide 'init-lsp)

;;; init-lsp.el ends here
