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
    (kbd "M-v") 'View-scroll-half-page-backward)

  (evil-define-key '(normal motion) 'global
    "\\" 'evil-motion-state
    "U" 'evil-redo
    "+" 'evil-numbers/inc-at-pt
    "-" 'evil-numbers/dec-at-pt
    (kbd "<leader>0") 'delete-window
    (kbd "<leader>q") 'hydra-high-frequency/body
    (kbd "<leader>r") 'hydra-edit/body
    (kbd "<leader>SPC") 'keyboard-escape-quit
    (kbd "<leader>d") 'xref-find-definitions
    (kbd "<leader>f") 'xref-find-references
    (kbd "<leader>w") 'xref-find-definitions-other-window
    (kbd "<leader>i") 'consult-imenu
    (kbd "<leader>c") 'consult-recent-file
    (kbd "<leader>C") 'consult-bookmark)

  (evil-define-key '(normal insert) 'global
    (kbd "C-q") 'hydra-high-frequency/body
    (kbd "C-r") 'hydra-edit/body
    (kbd "M-y") 'consult-yank-pop)

  (evil-define-key '(normal motion) 'org-mode-map
    (kbd "TAB") 'org-cycle
    (kbd "S-TAB") 'org-shifttab)

  (if (require 'embark nil t)
      (evil-define-key 'normal 'global
        (kbd "C-.") 'embark-act))

  (if (require 'puni nil t)
      (evil-define-key 'normal 'global
        (kbd "C-k") 'puni-kill-line)))

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

  (let ((modes '(prog-mode
                 text-mode
                 conf-mode
                 messages-buffer-mode)))
    (dolist (mode modes)
      (evil-set-initial-state mode 'normal)))

  (evil-select-search-module 'evil-search-module 'evil-search)
  (setup-evil-keys))

(use-package evil-escape
  :after evil
  :diminish evil-escape-mode
  ;; Bind F16 aka <print> key to `evil-escape',
  ;; Map Esc key to F16 when use terminal on Windows 10.
  :bind ("<print>" . evil-escape)
  :hook (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk"
                evil-escape-delay 0.2
                evil-want-fine-undo t))

(use-package evil-surround
  :after evil
  :hook (evil-mode . evil-surround-mode))

(use-package evil-matchit
  :after evil
  :hook (evil-mode . evil-matchit-mode))

(use-package evil-anzu
  :after evil)

(use-package evil-collection
  :config
  (evil-collection-init '(vterm
                          dired
                          eshell
                          flycheck
                          flymake
                          quickrun)))

(provide 'init-evil)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-evil.el ends here
