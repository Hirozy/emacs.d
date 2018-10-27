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
                    undo-tree))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode 1))

;; A Collection of Ridiculously Useful eXtensions for Emacs.
;; crux bundles a few useful interactive commands to enhance your overall Emacs experience.
;; Such as crux-smart-kill-line, crux-smart-open-line.
(use-package crux)

(use-package format-all)

(use-package iedit)

(provide 'init-editing)

;;; init-editing.el ends here
