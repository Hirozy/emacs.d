;;; init-evil.el --- evil-mode configuration

;;; Commentary:
;;
;; evil-mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(evil
                    evil-anzu
                    evil-escape
                    evil-matchit))

(use-package evil
  :bind (("C-\\" . evil-mode)
         :map evil-normal-state-map
         ("U" . evil-redo)
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-." . counsel-semantic-or-imenu)
         :map evil-insert-state-map
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-." . counsel-semantic-or-imenu))
  :config
  (evil-set-undo-system 'undo-tree)
  (setq evil-default-state 'emacs)
  (evil-set-initial-state 'prog-mode 'normal)
  (evil-set-initial-state 'org-mode 'normal)
  (evil-mode)

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

(provide 'init-evil)

;;; init-evil.el ends here
