;;; init-git.el --- Git tools configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Git tools configuration
;;

;;; Code:

(use-package magit
  :defer t
  :commands (magit-add-section-hook)
  :bind ("C-x m" . magit)

  :config
  (setq magit-module-sections-hook
        '(magit-insert-modules-unpulled-from-upstream
          magit-insert-modules-unpulled-from-pushremote
          magit-insert-modules-unpushed-to-upstream
          magit-insert-modules-unpushed-to-pushremote))
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules
                          'magit-insert-stashes
                          'append))

(use-package gptel-magit
  :after magit
  :bind(:map git-commit-mode-map
             ("C-c m" . gptel-magit-generate-message)))

(provide 'init-git)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-git.el ends here
