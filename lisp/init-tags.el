;;; init-tags.el --- Tags configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Tags configuration
;;

;;; Code:

(use-package citre
  :defer t
  :functions (projectile-project-root)
  :after projectile
  :bind (("C-," . citre-jump-back))

  :init
  (require 'citre-config)
  (require 'citre-global)

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
