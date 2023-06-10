;;; init-utils.el --- Utils configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Utils configuration
;;

;;; Code:

(use-package which-key
  :hook (after-init . which-key-mode)
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 1
        which-key-popup-type 'minibuffer))

(use-package avy
  :bind (("C-x C-SPC" . avy-pop-mark)
         ("C-;" . avy-goto-word-1)
         ("M-z" . avy-goto-word-1)))

(use-package winner
  :hook (after-init . winner-mode))

(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'abbrev-mode)
  (diminish 'auto-revert-mode))

(use-package treemacs
  :bind ("s-t" . treemacs-select-window)
  :config
  (use-package treemacs-projectile
    :after (treemacs projectile))

  (use-package treemacs-evil
    :after (treemacs evil))

  (use-package treemacs-magit
    :after (treemacs magit)))

(use-package nerd-icons
  ;; Install "Symbols Nerd Font Mono" font manual
  )

(use-package treemacs-nerd-icons
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package kind-icon
  :after corfu
  :config
  (setq kind-icon-use-icons nil)
  (setq kind-icon-mapping
        `((array ,(nerd-icons-codicon "nf-cod-symbol_array") :face font-lock-type-face)
          (boolean ,(nerd-icons-codicon "nf-cod-symbol_boolean") :face font-lock-builtin-face)
          (class ,(nerd-icons-codicon "nf-cod-symbol_class") :face font-lock-type-face)
          (color ,(nerd-icons-codicon "nf-cod-symbol_color") :face success)
          (command ,(nerd-icons-codicon "nf-cod-terminal") :face default)
          (constant ,(nerd-icons-codicon "nf-cod-symbol_constant") :face font-lock-constant-face)
          (constructor ,(nerd-icons-codicon "nf-cod-triangle_right") :face font-lock-function-name-face)
          (enummember ,(nerd-icons-codicon "nf-cod-symbol_enum_member") :face font-lock-builtin-face)
          (enum-member ,(nerd-icons-codicon "nf-cod-symbol_enum_member") :face font-lock-builtin-face)
          (enum ,(nerd-icons-codicon "nf-cod-symbol_enum") :face font-lock-builtin-face)
          (event ,(nerd-icons-codicon "nf-cod-symbol_event") :face font-lock-warning-face)
          (field ,(nerd-icons-codicon "nf-cod-symbol_field") :face font-lock-variable-name-face)
          (file ,(nerd-icons-codicon "nf-cod-symbol_file") :face font-lock-string-face)
          (folder ,(nerd-icons-codicon "nf-cod-folder") :face font-lock-doc-face)
          (interface ,(nerd-icons-codicon "nf-cod-symbol_interface") :face font-lock-type-face)
          (keyword ,(nerd-icons-codicon "nf-cod-symbol_keyword") :face font-lock-keyword-face)
          (macro ,(nerd-icons-codicon "nf-cod-symbol_misc") :face font-lock-keyword-face)
          (magic ,(nerd-icons-codicon "nf-cod-wand") :face font-lock-builtin-face)
          (method ,(nerd-icons-codicon "nf-cod-symbol_method") :face font-lock-function-name-face)
          (function ,(nerd-icons-codicon "nf-cod-symbol_method") :face font-lock-function-name-face)
          (module ,(nerd-icons-codicon "nf-cod-file_submodule") :face font-lock-preprocessor-face)
          (numeric ,(nerd-icons-codicon "nf-cod-symbol_numeric") :face font-lock-builtin-face)
          (operator ,(nerd-icons-codicon "nf-cod-symbol_operator") :face font-lock-comment-delimiter-face)
          (param ,(nerd-icons-codicon "nf-cod-symbol_parameter") :face default)
          (property ,(nerd-icons-codicon "nf-cod-symbol_property") :face font-lock-variable-name-face)
          (reference ,(nerd-icons-codicon "nf-cod-references") :face font-lock-variable-name-face)
          (snippet ,(nerd-icons-codicon "nf-cod-symbol_snippet") :face font-lock-string-face)
          (string ,(nerd-icons-codicon "nf-cod-symbol_string") :face font-lock-string-face)
          (struct ,(nerd-icons-codicon "nf-cod-symbol_structure") :face font-lock-variable-name-face)
          (text ,(nerd-icons-codicon "nf-cod-text_size") :face font-lock-doc-face)
          (typeparameter ,(nerd-icons-codicon "nf-cod-list_unordered") :face font-lock-type-face)
          (type-parameter ,(nerd-icons-codicon "nf-cod-list_unordered") :face font-lock-type-face)
          (unit ,(nerd-icons-codicon "nf-cod-symbol_ruler") :face font-lock-constant-face)
          (value ,(nerd-icons-codicon "nf-cod-symbol_field") :face font-lock-builtin-face)
          (variable ,(nerd-icons-codicon "nf-cod-symbol_variable") :face font-lock-variable-name-face)
          (t ,(nerd-icons-codicon "nf-cod-code") :face font-lock-warning-face)))
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package hl-indent-scope
  :hook (((c-mode
           c++-mode
           cmake-mode
           python-mode
           emacs-lisp-mode
           rust-mode
           go-mode
           haskell-mode) . hl-indent-scope-mode)
         (after-load-theme . (lambda (&rest args)
                               (hl-indent-scope--auto-color-calc)))))

;; Highlight the current line
(use-package hl-line
  ;; :custom-face
  ;; (hl-line ((t (:underline "dodger blue"))))
  :hook (((eshell-mode shell-mode term-mode vterm-mode) .
          (lambda () (setq-local global-hl-line-mode nil))))
  :config
  (global-hl-line-mode))

(use-package popper
  :hook (after-init . popper-mode)
  :commands (popper-group-by-projectile)
  :bind (:map popper-mode-map
              ("C-'" . popper-toggle-latest)
              ("M-'" . popper-cycle)
              ("s-'" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*Completions\\*"
          "\\*Quail Completions\\*"
          "\\*Warnings\\*"
          "\\*Apropos\\*"
          "\\*Backtrace\\*"
          "\\*Calendar\\*"
          "\\*Borg.*\\*$"
          "\\*quickrun\\*$"
          "\\*eldoc for.*\\*$"
          "\\*format-all-errors\\*"
          "\\*rust-.*\\*$"
          "\\*rustic-.*\\*$"

          help-mode
          compilation-mode
          "^\\*eshell.*\\*.*$" eshell-mode
          "^\\*shell.*\\*.*$"  shell-mode
          "^\\*terminal.*\\*.*$" term-mode
          "^\\*vterm.*\\*.*$"  vterm-mode))
  (setq popper-group-funcsytion #'popper-group-by-projectile
        popper-echo-dispatch-actions t))

(use-package popper-echo
  :commands popper-mode
  :config
  (popper-echo-mode))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'reverse
        uniquify-separator " • "
        niquify-after-kill-buffer-p t))

;; repeat `C-x o' `C-x o' to `C-x o o RET'
(use-package repeat
  :hook (after-init . repeat-mode)
  :custom
  (repeat-exit-key (kbd "RET")))

(use-package goto-chg :defer t)

(use-package uuidgen :defer t)

(use-package open-newline :defer t)

(use-package helpful
  :defer t
  :bind (("C-h F" . helpful-callable)
         ("C-h V" . helpful-variable)
         ("C-h X" . helpful-command)
         ("C-h C-d" . helpful-at-point)
         ("C-h C-f" . helpful-function)))

(provide 'init-utils)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-utils.el ends here
