;;; init-tags.el --- Tags configuration

;;; Commentary:
;;
;; Tags configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(xref))

(use-package xref
  :bind (("<f12>" . xref-find-definitions)
         ("S-<f12>" . xref-find-references)))

(use-package semantic
  :config
  (setq semantic-default-submodes
        '(global-semantic-idle-scheduler-mode
          global-sementic-minor-mode))
  (semantic-mode 1))

(provide 'init-tags)

;;; init-tags.el ends here
