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

  (use-package treemacs-icons-dired
    :if (memq window-system '(mac ns x))
    :config
    (treemacs-icons-dired-mode))

  (use-package treemacs-magit
    :after (treemacs magit)))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))

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
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-h C-d" . helpful-at-point)
         ("C-h F" . helpful-function)))

(provide 'init-utils)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-utils.el ends here
