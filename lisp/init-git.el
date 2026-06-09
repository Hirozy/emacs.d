;;; init-git.el --- Git tools configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Git tools configuration
;;

;;; Code:

(use-package magit
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
                          'append)
  ;; Cannot use ':hook (magit-post-refresh . diff-hl-magit-post-refresh)' to add hook,
  ;; otherwise it will override the default value of `magit-post-refresh-hook'.
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package git-commit
  :after magit
  :config
  (remove-hook 'git-commit-setup-hook #'git-commit-setup-capf))

(use-package magit-llm-commit
  :hook (magit-mode . magit-llm-commit-install)
  :custom
  (magit-llm-commit-api-url "https://openrouter.ai/api/v1/chat/completions")
  (magit-llm-commit-model "anthropic/claude-haiku-4.5")
  :after magit
  :config
  (setq magit-llm-commit-api-key (defined/get-auth-password "openrouter.ai")))

(use-package diff-hl
  :hook (((prog-mode markdown-mode org-mode text-mode) . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)))

(provide 'init-git)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-git.el ends here
