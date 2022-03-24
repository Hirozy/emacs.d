;;; init-configs.el --- editing tools configuration

;;; Commentary:
;;
;; editing tools configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(anzu
                    ctrlf
                    expand-region
                    format-all
                    hungry-delete
                    iedit
                    symbol-overlay
                    undo-fu
                    undo-fu-session
                    whitespace-cleanup-mode))


(use-package undo-fu
  :config
  (use-package undo-fu-session
    :config
    (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
    (global-undo-fu-session-mode)))


(use-package iedit
  :bind ("S-<f2>" . iedit-mode)
  :custom-face
  (iedit-occurrence ((t (:background "#CDB48B" :foreground "black" :inverse-video nil)))))

(use-package whitespace-cleanup-mode
  :diminish whitespace-cleanup-mode
  :hook (prog-mode . whitespace-cleanup-mode))

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
  :bind (("C-s" . ctrlf-forward-default)
         ("C-M-s" . ctrlf-forward-alternate)
         ("M-s _" . ctrlf-forward-symbol)
         ("M-s ." . ctrlf-forward-symbol-at-point)))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package symbol-overlay
  :diminish symbol-overlay-mode
  :bind-keymap
  ("C-c i" . symbol-overlay-map)
  :hook (prog-mode . symbol-overlay-mode))

(use-package hungry-delete
  :config
  (setq hungry-delete-join-reluctantly nil))

(global-set-key (kbd "C-x ;") 'comment-line)
(global-set-key (kbd "C-x C-;") 'comment-set-column)

(provide 'init-editing)

;;; init-editing.el ends here
