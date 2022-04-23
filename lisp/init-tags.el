;;; init-tags.el --- Tags configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Tags configuration
;;

;;; Code:

(use-package citre
  :defer t
  :functions (projectile-project-root)
  :after projectile
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
  :defer t
  :bind (("<f12>" . xref-find-definitions)
         ("S-<f12>" . xref-find-references)))

(use-package semantic
  :defer t
  :config
  (setq semantic-default-submodes
        '(global-semantic-idle-scheduler-mode
          global-sementic-minor-mode))
  (semantic-mode 1))

(provide 'init-tags)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-tags.el ends here
