;;; init-tags.el --- Tags configuration

;;; Commentary:
;;
;; Tags configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(citre
                    xref))

(use-package citre
  :after projectile
  :defer t
  :bind (("C-x c j" . citre-jump)
         ("C-x c J" . citre-jump-back)
         ("C-x c p" . citre-peek)
         ("C-x c P" . citre-ace-peek)
         ("C-x c e" . citre-edit-tags-file-recipe)
         ("C-x c u" . citre-update-this-tags-file))
  :init
  (require 'citre-config)

  :config
  (setq citre-project-root-function #'projectile-project-root
        citre-default-create-tags-file-location 'global-cache
        citre-use-project-root-when-creating-tags t
        citre-prompt-language-for-ctags-command t
        citre-auto-enable-citre-mode-modes '(prog-mode)))

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
