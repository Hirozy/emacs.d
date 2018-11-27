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
  :config
  (setq lsp-message-project-root-warning t))

(use-package lsp-ui
  :init
  ;; https://github.com/cquery-project/emacs-cquery/issues/45#issuecomment-406813724
  (add-hook 'lsp-after-open-hook 'lsp-ui-mode))

(use-package lsp-imenu
  :init
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

(provide 'init-lsp)

;;; init-lsp.el ends here
