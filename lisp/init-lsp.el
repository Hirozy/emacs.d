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
                    lsp-ivy
                    ccls))

(use-package lsp-mode

  :config
  (use-package lsp-ui
    ;; https://github.com/cquery-project/emacs-cquery/issues/45
    :hook (lsp-after-open . lsp-ui-mode))

  (use-package company-lsp
    :hook ((c-mode c++-mode objc-mode) .
           (lambda ()
             (lsp)
             (set (make-local-variable 'company-backends)
                  '(company-lsp company-yasnippet)))))

  (use-package ccls
    :config
    (setq ccls-executable "ccls")
    (setq lsp-prefer-flymake nil)
    (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
    :hook ((c-mode c++-mode objc-mode) .
           (lambda ()
             (require 'ccls)
             (lsp)))))

(provide 'init-lsp)

;;; init-lsp.el ends here
