;;; init-pair.el --- Pair configuration

;;; Commentary:
;;
;; Pair configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(rainbow-delimiters))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package awesome-pair
  :load-path "site-lisp/awesome-pair"
  :hook ((lisp-mode . awesome-pair-mode)
         (c++-mode . awesome-pair-mode)
         (c-mode . awesome-pair-mode)
         (python-mode . awesome-pair-mode)
         (go-mode . awesome-pair-mode)
         (org-mode . awesome-pair-mode)
         (markdown-mode . awesome-pair-mode)
         (latex-mode . awesome-pair-mode)
         (minibuffer-inactive-mode . awesome-pair-mode))
  :bind (("(" . awesome-pair-open-round)
         ("[" . awesome-pair-open-bracket)
         ("{" . awesome-pair-open-curly)
         (")" . awesome-pair-close-round)
         ("]" . awesome-pair-close-bracket)
         ("}" . awesome-pair-close-curly)
         ("%" . awesome-pair-match-paren)
         ("\"" . awesome-pair-double-quote)
         ("M-o" . awesome-pair-backward-delete)
         ("C-k" . awesome-pair-kill)
         ("M-\"" . awesome-pair-wrap-double-quote)
         ("M-[" . awesome-pair-wrap-bracket)
         ("M-{" . awesome-pair-wrap-curly)
         ("M-(" . awesome-pair-wrap-round)
         ("M-)" . awesome-pair-unwrap)
         ("M-p" . awesome-pair-jump-right)
         ("M-n" . awesome-pair-jump-left)
         ("M-:" . awesome-pair-jump-out-pair-and-newline)))

(use-package elec-pair
  :init
  (setq electric-pair-pairs '((?\' . ?\')))
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (setq-local electric-pair-pairs nil)))
  :config
  (electric-indent-mode 1)
  (electric-pair-mode 1))

(use-package paren
  :config
  (show-paren-mode 1))

(provide 'init-pair)

;;; init-pair.el ends here
