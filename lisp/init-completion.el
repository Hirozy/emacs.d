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
                    yasnippet
                    yasnippet-snippets))

(setq-default indent-tabs-mode nil
              tab-width 4)

(use-package company
  :hook ((after-init . global-company-mode)
         ((shell-mode
           eshell-mode) . (lambda ()
           (company-mode -1))))
  :bind (:map company-active-map
              ("<tab>" . company-complete-common-or-cycle)
              ("<backtab>" . company-other-backend)
              ("M-i" . yas-expand)
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("M-n" . company-next-page)
              ("M-p" . company-previous-page)
              ("M-w" . company-show-location)
              ("C-s" . company-search-candidates)
              ("M-s" . company-filter-candidates))

  :init
  (setq company-backends '(company-capf
                           company-cmake
                           company-dabbrev
                           company-dabbrev-code
                           company-keywords
                           company-files))
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-require-match nil
        company-show-quick-access t)

  (use-package company-box
    :diminish company-box-mode
    :hook (company-mode . company-box-mode)))

(use-package yasnippet
  :diminish yas-minor-mode
  :custom
  (yas-use-menu nil)
  :config
  (yas-global-mode 1))

(use-package flycheck
  :hook ((prog-mode . flycheck-mode)
         (latex-mode . (lambda ()
                         (flycheck-mode -1))))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c C-l"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map))

(use-package flymake
  :diminish flymake-mode
  :config
  (global-flycheck-mode -1))

(provide 'init-completion)

;;; init-completion.el ends here
