;;; init-configs.el --- editing tools configuration

;;; Commentary:
;;
;; editing tools configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(anzu
                    crux
                    ctrlf
                    expand-region
                    format-all
                    hungry-delete
                    iedit
                    multiple-cursors
                    symbol-overlay
                    undo-tree
                    wgrep
                    wgrep-ag
                    whitespace-cleanup-mode
                    zzz-to-char))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode 1))

;; A Collection of Ridiculously Useful eXtensions for Emacs.
;; crux bundles a few useful interactive commands to enhance your overall Emacs experience.
;; Such as crux-smart-kill-line, crux-smart-open-line.
(use-package crux)

(use-package iedit)

(use-package whitespace-cleanup-mode
  :diminish whitespace-cleanup-mode
  :hook (prog-mode . whitespace-cleanup-mode))

(use-package wgrep
  :config
  (use-package wgrep-ag))

(use-package anzu
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :custom
  (anzu-mode-lighter "")
  (anzu-replace-to-string-separator " -> ")
  :custom-face
  (anzu-replace-highlight ((t (:background "deepskyblue2" :foreground "snow" :strike-through nil :weight normal))))
  (anzu-replace-to ((t (:background "orange" :foreground "snow" :weight normal)))))

(use-package ctrlf
  :bind (("C-s" . ctrlf-forward-literal)
         ("C-M-s" . ctrlf-forward-regexp)
         ("M-s _" . ctrlf-forward-symbol)
         ("M-s ." . ctrlf-forward-symbol-at-point))
  :custom-face
  (ctrlf-highlight-active ((t (:inherit isearch :background "peru"))))
  (ctrlf-highlight-line ((t (:inherit hl-line :background "gray20" :underline t)))))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package symbol-overlay
  :bind-keymap
  ("C-c i" . symbol-overlay-map)
  :hook (prog-mode . symbol-overlay-mode))

(use-package zzz-to-char
  :custom
  (zzz-to-char-reach 4096)
  :bind (("M-z" . zzz-to-char)
         ("C-M-z" . zzz-up-to-char)))

(use-package hungry-delete
  :config
  (setq hungry-delete-join-reluctantly t))

(provide 'init-editing)

;;; init-editing.el ends here
