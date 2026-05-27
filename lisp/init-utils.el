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

(use-package nerd-icons
  ;; Install "Symbols Nerd Font Mono" font manual
  )

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
          "\\*rust-.*\\*$"
          "\\*rustic-.*\\*$"

          help-mode
          compilation-mode
          "^\\*eshell.*\\*.*$" eshell-mode
          "^\\*shell.*\\*.*$"  shell-mode
          "^\\*terminal.*\\*.*$" term-mode
          "^\\*vterm.*\\*.*$"  vterm-mode))
  (setq popper-group-function #'popper-group-by-projectile
        popper-echo-dispatch-actions t))

(use-package popper-echo
  :commands popper-mode
  :config
  (popper-echo-mode))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'reverse
        uniquify-separator " • "
        uniquify-after-kill-buffer-p t))

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

;; https://github.com/DogLooksGood/emacs-rime#%E7%BB%93%E5%90%88-evil-escape-%E4%B8%80%E8%B5%B7%E4%BD%BF%E7%94%A8
(defun rime-evil-escape-advice (orig-fun key)
  "Advice for `rime-input-method' to integrate with `evil-escape'.
When the escape key sequence (default \"jk\") is typed in insert state,
switch to normal state. Modified from `evil-escape-pre-command-hook'."
  (cond
   ;; Composing with rime - pass through
   (rime--preedit-overlay
    (funcall orig-fun key))
   ;; Check for evil-escape sequence
   ((not (featurep 'evil-escape))
    (funcall orig-fun key))
   (t
    (let ((fkey (elt evil-escape-key-sequence 0))
          (skey (elt evil-escape-key-sequence 1)))
      (if (not (or (char-equal key fkey)
                   (and evil-escape-unordered-key-sequence
                        (char-equal key skey))))
          (funcall orig-fun key)
        (let ((evt (read-event nil nil evil-escape-delay)))
          (cond
           ;; Complete escape sequence
           ((and (characterp evt)
                 (or (and (char-equal key fkey) (char-equal evt skey))
                     (and evil-escape-unordered-key-sequence
                          (char-equal key skey) (char-equal evt fkey))))
            (evil-repeat-stop)
            (evil-normal-state))
           ;; Timeout - process first key only
           ((null evt)
            (funcall orig-fun key))
           ;; Mismatch - process both keys
           (t
            (funcall orig-fun key)
            (if (characterp evt)
                (funcall orig-fun evt)
              (setq unread-command-events
                    (nconc unread-command-events (list evt))))))))))))

(use-package rime
  :bind (:map rime-mode-map
              ("M-j" . rime-force-enable))
  :custom
  (default-input-method "rime")
  (rime-show-candidate 'posframe)
  (rime-disable-predicates
   '(
     rime-predicate-after-alphabet-char-p ;; 在英文字母开头的字符串之后
     rime-predicate-after-ascii-char-p ;; 在任意 ASCII 字符之后
     ;; rime-predicate-prog-in-code-p ;; 在 prog-mode/conf-mode 的代码区域（注释和字符串除外）
     ;; rime-predicate-in-code-string-p ;; 在代码字符串中（不含注释）
     rime-predicate-evil-mode-p ;; 在 evil-mode 非 insert state 时
     rime-predicate-ace-window-p ;; 激活 ace-window 时
     rime-predicate-hydra-p ;; 激活 hydra keymap 时
     rime-predicate-current-input-punctuation-p ;; 输入符号时
     rime-predicate-punctuation-after-space-cc-p ;; 在中文字符后有空格时输入符号
     rime-predicate-punctuation-after-ascii-p ;; 在英文字符后输入符号时
     rime-predicate-punctuation-line-begin-p ;; 在行首输入符号时
     ;; rime-predicate-space-after-ascii-p ;; 在英文字符后有空格时
     rime-predicate-space-after-cc-p ;; 在中文字符后有空格时
     rime-predicate-current-uppercase-letter-p ;; 输入大写字母时
     rime-predicate-tex-math-or-command-p ;; 在 TeX 数学环境或命令中
     ))
  :config
  (advice-add 'rime-input-method :around #'rime-evil-escape-advice))

(use-package ghostel
  :defer t
  :custom
  (ghostel-tramp-shell-integration '(fish bash zsh)))

(provide 'init-utils)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-utils.el ends here
