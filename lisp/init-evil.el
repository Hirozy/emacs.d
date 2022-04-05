;;; init-evil.el --- evil-mode configuration

;;; Commentary:
;;
;; evil-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'evil)

;;; Code:

(require-packages '(evil
                    evil-anzu
                    evil-escape
                    evil-matchit))

(use-package evil
  :bind (("C-\\" . evil-force-normal-state)

         :map evil-normal-state-map
         ("U" . evil-redo)
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-." . counsel-semantic-or-imenu)
         ("C-k" . grammatical-edit-kill)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-\\" . evil-mode)

         :map evil-insert-state-map
         ("C-k" . grammatical-edit-kill)
         ("C-d" . grammatical-edit-forward-delete)
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-." . counsel-semantic-or-imenu)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-\\" . evil-mode)
         ("C-q" . hydra-high-frequency/body))

  :config
  (evil-set-undo-system 'undo-fu)
  (setq evil-default-state 'emacs
        evil-symbol-word-search t)
  (modify-syntax-entry ?_ "w")
  (evil-set-initial-state 'prog-mode 'normal)
  (evil-set-initial-state 'text-mode 'normal)
  (evil-set-initial-state 'fundamental-mode 'normal)

  (use-package evil-escape
    :diminish evil-escape-mode
    ;; Bind F16 aka <print> key to `evil-escape',
    ;; Map Esc key to F16 when use terminal on Windows 10.
    :bind ("<print>" . evil-escape)
    :hook (evil-mode . evil-escape-mode)
    :config
    (setq-default evil-escape-key-sequence "jk"
                  evil-escape-delay 0.2))
  (use-package evil-matchit)
  (use-package evil-anzu))

(evil-mode 1)

(provide 'init-evil)

;;; init-evil.el ends here
