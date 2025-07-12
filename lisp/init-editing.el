;;; init-configs.el --- editing tools configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; editing tools configuration
;;

;;; Code:

;; Automatically reload files was modified by external program
(use-package autorevert
  :diminish
  :hook (after-init . global-auto-revert-mode))

(use-package whitespace-cleanup-mode
  :diminish whitespace-cleanup-mode
  :hook ((prog-mode text-mode) . whitespace-cleanup-mode))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package symbol-overlay
  :diminish symbol-overlay-mode
  :bind-keymap
  ("C-c i" . symbol-overlay-map)
  :hook (prog-mode . symbol-overlay-mode))

(use-package hungry-delete
  :defer t
  :config
  (setq hungry-delete-join-reluctantly nil))

;; Move to the beginning/end of line or code
(use-package mwim
  :bind (([remap move-beginning-of-line] . mwim-beginning-of-code-or-line)
         ([remap move-end-of-line] . mwim-end-of-code-or-line)))

(use-package newcomment
  :bind (("C-x ;" . comment-line)
         ("C-x C-;" . comment-set-column)))

;; Handling capitalized subwords in a nomenclature
(use-package subword
  :diminish
  :hook (minibuffer-setup . subword-mode))

;; Delete selection if you insert
(use-package delsel
  :hook (after-init . delete-selection-mode))

(use-package undo-fu)

(use-package vundo)

(provide 'init-editing)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-editing.el ends here
