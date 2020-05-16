;;; init-completion.el --- Completion configuration

;;; Commentary:
;;
;; Completion configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(company
                    company-box
                    flycheck
                    avy-flycheck
                    yasnippet
                    aggressive-indent))

(setq-default indent-tabs-mode nil
              tab-width 4
              tab-always-indent 'complete)

(use-package company
  :hook ((after-init . global-company-mode)
         (after-init . (lambda ()
                         (delete 'company-clang company-backends)))
         ;; disable company-mode for shell and eshell
         (shell-mode . (lambda ()
                         (company-mode -1)))
         (eshell-mode . (lambda ()
                          (company-mode -1))))
  :bind (:map company-active-map
              ("TAB" . company-complete-selection)
              ("<tab>" . company-complete-selection)
              ("S-TAB" . yas-expand)
;;              ("[?\C-\t]" . yas-expand)
              ("M-/" . yas-expand)
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))

  :config
  (use-package company-dabbrev
    :init
    (setq company-dabbrev-ignore-case nil
          company-dabbrev-downcase nil))

  (use-package company-box
    :diminish company-box-mode
    :hook (company-mode . company-box-mode))

  :init
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-require-match nil))

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package flycheck
  :hook ((prog-mode . flycheck-mode)
         (latex-mode . (lambda ()
                         (flycheck-mode -1))))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)

  (use-package avy-flycheck
    :hook (global-flycheck-mode . avy-flycheck-setup)))

(provide 'init-completion)

;;; init-completion.el ends here
