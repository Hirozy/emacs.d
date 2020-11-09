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
                    eldoc
                    flycheck
                    yasnippet))

(setq-default indent-tabs-mode nil
              tab-width 4
              tab-always-indent 'complete)

(use-package company
  :hook ((after-init . global-company-mode)
         ;; disable company-mode for shell and eshell
         ((shell-mode
           eshell-mode) . (lambda ()
           (company-mode -1))))
  :bind (:map company-active-map
              ("TAB" . company-complete)
              ("<tab>" . company-complete)
              ("S-TAB" . yas-expand)
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
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c l"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map))

(use-package flymake
  :diminish flymake-mode
  :config
  (global-flycheck-mode -1))

(provide 'init-completion)

;;; init-completion.el ends here
