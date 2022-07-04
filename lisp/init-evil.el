;;; init-evil.el --- evil-mode configuration  -*- lexical-binding: t; -*-

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
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-." . embark-act)
         ("M-y" . consult-yank-pop)

         :map evil-insert-state-map
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-k" . kill-line)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-q" . hydra-high-frequency/body))

  :config
  (evil-set-undo-system 'undo-redo)
  (setq evil-default-state 'emacs
        evil-symbol-word-search t)
  (modify-syntax-entry ?_ "w")
  (evil-set-initial-state 'prog-mode 'normal)
  (evil-set-initial-state 'text-mode 'normal)
  (evil-set-initial-state 'conf-mode 'normal)
  (evil-set-initial-state 'fundamental-mode 'normal)
  (evil-select-search-module 'evil-search-module 'evil-search))

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

(provide 'init-evil)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-evil.el ends here
