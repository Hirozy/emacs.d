;;; init-configs.el --- editing tools configuration

;;; Commentary:
;;
;; editing tools configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(format-all
                    iedit
                    crux
                    undo-tree
                    whitespace-cleanup-mode
                    wgrep
                    wgrep-ag
                    anzu
                    ctrlf
                    expand-region
                    symbol-overlay
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
         ("C-M-s" . ctrlf-forward-regexp)))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package symbol-overlay
  :bind-keymap
  ("C-c *" . symbol-overlay-map)
  :hook (prog-mode . symbol-overlay-mode))

(use-package zzz-to-char
  :custom
  (zzz-to-char-reach 4096)
  :bind (("M-z" . zzz-to-char)
         ("C-M-z" . zzz-up-to-char)))

(provide 'init-editing)

;;; init-editing.el ends here
