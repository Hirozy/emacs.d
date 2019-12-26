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
                    whitespace-cleanup-mode))

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

(provide 'init-editing)

;;; init-editing.el ends here
