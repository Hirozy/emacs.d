;;; init-evil.el --- evil-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; evil-mode configuration
;;

;;; Code:

(defun setup-evil-keys ()
  "Setup evil keys."
  (evil-define-key '(normal visual insert motion) 'global
    (kbd "C-a") 'move-beginning-of-line
    (kbd "C-e") 'move-end-of-line
    (kbd "C-n") 'next-line
    (kbd "C-p") 'previous-line
    (kbd "C-v") 'View-scroll-half-page-forward
    (kbd "M-v") 'View-scroll-half-page-backward
    (kbd "M-,") 'xref-go-back
    (kbd "M-.") 'xref-go-forward)

  (evil-define-key '(normal motion) 'global
    "\\" 'evil-motion-state
    "U" 'evil-redo
    "+" 'evil-numbers/inc-at-pt
    "-" 'evil-numbers/dec-at-pt
    (kbd "<leader>x") 'delete-window
    (kbd "<leader>q") 'hydra-freq/body
    (kbd "<leader>r") 'hydra-edit/body
    (kbd "<leader>SPC") 'keyboard-escape-quit
    (kbd "<leader>f") 'consult-projectile
    (kbd "<leader>i") 'consult-imenu
    (kbd "<leader>c") 'consult-recent-file
    (kbd "<leader>C") 'consult-bookmark)

  (evil-define-key '(normal motion insert) prog-mode-map
    (kbd "<leader>d") 'xref-find-definitions
    (kbd "<leader>h") 'xref-find-references
    (kbd "<leader>w") 'xref-find-definitions-other-window
    (kbd "<leader>,") 'xref-go-back
    (kbd "<leader>.") 'xref-go-forward
    (kbd "<leader>j") 'tags-keys/body)

  (evil-define-key '(normal insert) 'global
    (kbd "C-q") 'hydra-freq/body
    (kbd "C-r") 'hydra-edit/body
    (kbd "M-y") 'consult-yank-pop)

  (evil-define-key '(normal motion insert) org-mode-map
    (kbd "TAB") 'org-cycle
    (kbd "S-TAB") 'org-shifttab
    (kbd "C-,") 'org-mark-ring-goto)

  (if (require 'embark nil t)
      (evil-define-key 'normal 'global
        (kbd "C-.") 'embark-act))

  (if (require 'puni nil t)
      (evil-define-key 'normal 'global
        (kbd "C-k") 'puni-kill-line))

  (if (require 'org-roam nil t)
      (progn
        (evil-define-key 'normal 'global
          (kbd "<leader>n") 'org-roam-node-find
          (kbd "<leader>m") 'org-roam-capture
          (kbd "<leader>,") 'org-keys/body)
        (evil-define-key 'normal org-mode-map
          (kbd "RET") 'org-open-at-point
          (kbd "<return>") 'org-open-at-point
          "," 'org-keys/body
          "<" 'org-metaleft
          ">" 'org-metaright))))

(defun defined/insert-with-space ()
  "Evil insert with space."
  (interactive)
  (insert-char (char-from-name "SPACE"))
  (backward-char)
  (evil-insert-state))

(use-package evil
  :hook ((after-init . evil-mode)
         ((yaml-mode) . (lambda ()
                          (setq-local evil-shift-width 2))))
  :bind (("C-\\" . evil-force-normal-state))

  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)

  :config
  (evil-set-undo-system 'undo-redo)
  (setq evil-default-state 'emacs
        evil-symbol-word-search t)
  (evil-set-leader '(normal motion) (kbd "SPC"))
  ;; (modify-syntax-entry ?_ "w")

  (dolist (mode '(prog-mode
                  text-mode
                  conf-mode))
    (evil-set-initial-state mode 'normal))

  (dolist (mode '(help-mode
                  special-mode
                  messages-buffer-mode))
    (evil-set-initial-state mode 'motion))

  (evil-select-search-module 'evil-search-module 'evil-search)
  (setup-evil-keys))

(use-package key-chord
  :hook (after-init . key-chord-mode)
  :after evil
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "Jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))

(use-package evil-surround
  :after evil
  :hook (evil-mode . evil-surround-mode))

(use-package evil-matchit
  :after evil
  :hook (evil-mode . evil-matchit-mode))

(use-package evil-anzu
  :after evil)

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :config
  (evil-collection-init '(dired
                          quickrun)))

(provide 'init-evil)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-evil.el ends here
