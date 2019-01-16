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
                    company-lsp))

(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-message-project-root-warning t))

(use-package lsp-ui
  ;; https://github.com/cquery-project/emacs-cquery/issues/45
  :hook (lsp-after-open . lsp-ui-mode))

(use-package company-lsp
  :commands company-lsp)

(provide 'init-lsp)

;;; init-lsp.el ends here
