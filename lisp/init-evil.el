;;; init-evil.el --- evil-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; evil-mode configuration
;;

;;; Code:

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
  :bind (("C-\\" . evil-force-normal-state)
         ("C-c +" . evil-numbers/inc-at-pt)
         ("C-c -" . evil-numbers/dec-at-pt)

         :map evil-normal-state-map
         ("U" . evil-redo)
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-." . embark-act)
         ("M-y" . consult-yank-pop)
         ("C-v" . evil-scroll-page-down)
         ("M-v" . evil-scroll-page-up)

         :map evil-insert-state-map
         ("C-e" . move-end-of-line)
         ("C-r" . hydra-edit/body)
         ("C-k" . kill-line)
         ("C-a" . move-beginning-of-line)
         ("C-n" . next-line)
         ("C-p" . previous-line)
         ("C-q" . hydra-high-frequency/body))

  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)

  :config
  (evil-set-undo-system 'undo-redo)
  (setq evil-default-state 'emacs
        evil-symbol-word-search t)
  ;; (modify-syntax-entry ?_ "w")

  (let ((modes '(prog-mode
                 text-mode
                 conf-mode
                 fundamental-mode
                 vterm-mode
                 dired-mode
                 eshell-mode)))
    (dolist (mode modes)
      (evil-set-initial-state mode 'normal)))

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

(use-package evil-collection
  :config
  (evil-collection-init '(vterm
                          dired
                          magit
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
