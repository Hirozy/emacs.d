;;; init-tags.el --- Tags configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Tags configuration
;;

;;; Code:

(transient-define-prefix transient-tags ()
  "Tags Navigation and Management.
Jump to definitions and references using Citre, and manage ctags/gtags databases."
  [["Citre"
    ("j" "Citre jump" citre-jump)
    ("l" "Citre jump to reference" citre-jump-to-reference)
    ("b" "Citre jump back" citre-jump-back)
    ("p" "Citre peek" citre-peek)
    ("t" "Citre peek through" citre-peek-through)]
   ["Update"
    ("c" "Create ctags file" citre-create-tags-file)
    ("C" "Create gtags database" citre-global-create-database)
    ("u" "Update ctags file" citre-update-this-tags-file)
    ("U" "Update gtags database" citre-global-update-database)]]
  [("SPC" "Quit" transient-quit-all)])

(use-package citre
  :functions (projectile-project-root)
  :bind (("s-j" . transient-tags)
         ("C-c C-q j" . transient-tags))
  :custom
  (citre-enable-capf-integration nil)
  (citre-gtags-args '("--sqlite3" "--compact" "--objdir"))
  :hook (prog-mode . citre-mode)
  :config
  (require 'citre-config)
  (setq citre-project-root-function #'projectile-project-root
        citre-default-create-tags-file-location 'global-cache))

(use-package xref
  :defer t
  :bind (("<f12>" . xref-find-definitions)
         ("S-<f12>" . xref-find-references)
         ("M-." . xref-find-definitions)
         ("M-?" . xref-find-references))
  :config
  (setq xref-history-storage 'xref-window-local-history)
  ;; Make `xref-go-back' everywhere
  (defun defined/push-point-to-xref-marker-stack (&rest _)
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
                                bookmark-jump
                                citre-jump))
    (advice-add func :before 'defined/push-point-to-xref-marker-stack)))

(use-package semantic
  :defer t
  :config
  (setq semantic-default-submodes
        '(global-semantic-idle-scheduler-mode
          global-semantic-minor-mode))
  (semantic-mode 1))

(provide 'init-tags)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-tags.el ends here
