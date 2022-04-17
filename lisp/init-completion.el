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
                    company-prescient
                    eldoc
                    flycheck
                    yasnippet))

(setq-default indent-tabs-mode nil
              tab-width 4)

(use-package company
  :diminish company-mode
  :defines (company-files-exclusions company-dabbrev-ignore-case company-dabbrev-downcase)
  :hook ((after-init . global-company-mode))
  :bind (("M-/" . company-other-backend)
         :map company-active-map
         ("<tab>" . company-complete-common-or-cycle)
         ("M-i" . yas-expand)
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("M-n" . company-next-page)
         ("M-p" . company-previous-page)
         ("M-w" . company-show-location)
         ("C-s" . company-filter-candidates)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))

  :init
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-require-match nil
        company-show-quick-access t
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-files-exclusions '(".git/" ".DS_Store")
        company-global-modes '(not erc-mode
                                   message-mode
                                   help-mode
                                   eshell-mode
                                   shell-mode)
        company-backends '((company-capf :with company-dabbrev-code)
                           (company-cmake
                            company-dabbrev-code
                            company-keywords
                            company-files)
                           company-dabbrev)))

(use-package company-box
  :after lsp-mode
  :diminish company-box-mode
  :hook (company-mode . company-box-mode))

(use-package company-prescient
  :after company
  :config
  (company-prescient-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :defer t
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
