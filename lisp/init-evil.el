;;; init-evil.el --- evil-mode configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; evil-mode configuration
;;

;;; Code:

(use-package evil
  :hook (after-init . evil-mode)
  :bind (("C-\\" . evil-force-normal-state)

         :map evil-normal-state-map
         ("U" . evil-redo)
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-." . consult-imenu)
         ("C-k" . grammatical-edit-kill)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-\\" . evil-mode)
         ("M-y" . consult-yank-pop)

         :map evil-insert-state-map
         ("C-k" . grammatical-edit-kill)
         ("C-d" . grammatical-edit-forward-delete)
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-." . consult-imenu)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-\\" . evil-mode)
         ("C-q" . hydra-high-frequency/body))

  :config
  (evil-set-undo-system 'undo-redo)
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
                  evil-escape-delay 0.2
                  evil-want-fine-undo t))
  (use-package evil-matchit)
  (use-package evil-anzu))

(provide 'init-evil)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-evil.el ends here
