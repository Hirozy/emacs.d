;;; init-tags.el --- Tags configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Tags configuration
;;

;;; Code:

(use-package citre
  :defer t
  :functions (projectile-project-root)
  :config
  (require 'citre-config)
  (setq citre-project-root-function #'projectile-project-root
        ;; citre-mode will be exclusive to capf, so disable it now
        ;; citre-auto-enable-citre-mode-modes '(prog-mode)
        citre-default-create-tags-file-location 'global-cache
        citre-use-project-root-when-creating-tags t
        citre-prompt-language-for-ctags-command t))

(use-package xref
  :defer t
  :bind (("<f12>" . xref-find-definitions)
         ("S-<f12>" . xref-find-references))

  :config
  (setq xref-history-storage 'xref-window-local-history)
  ;; Make `xref-go-back' everywhere
  (defun defined/push-point-to-xref-marker-stack (&rest r)
    (xref-push-marker-stack (point-marker)))
  (dolist (func '(find-function consult-imenu
                                consult-ripgrep
                                consult-grep
                                consult-file
                                consult-recent-file
                                consult-projectile
                                consult-bookmark
                                consult-projectile-recentf
                                consult-projectile-find-file
                                org-roam-node-find
                                vulpea-find
                                citre-jump))
    (advice-add func :before 'defined/push-point-to-xref-marker-stack)))

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
