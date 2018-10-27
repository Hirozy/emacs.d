;;; init-completion.el --- Completion configuration

;;; Commentary:
;;
;; Completion configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(company
                    flycheck
                    yasnippet
                    yasnippet-snippets))

(setq-default indent-tabs-mode nil
              tab-width 4
              tab-always-indent 'complete)

(use-package company
  :init
  (progn
    (setq company-idle-delay 0.1
          company-minimum-prefix-length 1
          company-require-match nil
          company-dabbrev-ignore-case nil
          company-dabbrev-downcase nil)
    (add-hook 'after-init-hook 'global-company-mode)))

;; https://github.com/company-mode/company-mode/wiki/Switching-from-AC
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
     (define-key company-active-map (kbd "M-/") 'company-other-backend)
     (define-key company-active-map (kbd "C-n") 'company-select-next)
     (define-key company-active-map (kbd "C-p") 'company-select-previous)))

;; disable company-mode for shell in Emacs
(add-hook 'shell-mode-hook (lambda ()
                             (company-mode -1))
          'append)

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package flycheck
  :hook
  (after-init . global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit))

(provide 'init-completion)

;;; init-completion.el ends here
