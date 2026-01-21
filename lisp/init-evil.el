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
    (kbd "C-v") 'scroll-up-command
    (kbd "M-v") 'scroll-down-command
    (kbd "C-M-,") 'xref-go-back
    (kbd "C-M-.") 'xref-go-forward)

  (evil-define-key '(normal motion) 'global
    "\\" 'evil-motion-state
    "U" 'evil-redo
    "+" 'evil-numbers/inc-at-pt
    "-" 'evil-numbers/dec-at-pt
    (kbd "<leader>x") 'delete-window
    (kbd "<leader>q") 'hydra-freq/body
    (kbd "<leader>r") 'hydra-edit/body
    (kbd "<leader>z") 'avy-goto-char
    (kbd "<leader>SPC") 'keyboard-escape-quit)

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

  (if (require 'denote nil t)
      (progn
        (evil-define-key 'normal 'global
          (kbd "<leader>n") 'org-keys/body)
        (evil-define-key 'normal org-mode-map
          (kbd "RET") 'org-open-at-point
          (kbd "<return>") 'org-open-at-point
          (kbd ",") 'org-keys/body
          "<" (lambda (&rest args)
                (interactive)
                (if (org-in-src-block-p)
                    (call-interactively 'evil-shift-left t (vector args))
                  (org-metaleft)))
          ">" (lambda (&rest args)
                (interactive)
                (if (org-in-src-block-p)
                    (call-interactively 'evil-shift-right t (vector args))
                  (org-metaright)))))))

(use-package evil
  :hook ((after-init . evil-mode)
         ((yaml-mode) . (lambda ()
                          (setq-local evil-shift-width 2))))
  :bind (("C-\\" . evil-force-normal-state))

  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)

  :config
  (evil-set-undo-system 'undo-fu)
  (setq evil-default-state 'emacs
        evil-symbol-word-search t
        ;; don't aggregate changes
        evil-want-fine-undo t)
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

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package evil-matchit
  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-escape
  :diminish evil-escape-mode
  :hook (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk"
                evil-escape-delay 0.2
                evil-want-fine-undo t))

(provide 'init-evil)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-evil.el ends here
