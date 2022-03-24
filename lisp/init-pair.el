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

(use-package grammatical-edit
  :load-path "site-lisp/grammatical-edit"
  :hook ((lisp-mode
          c++-mode
          c-mode
          python-mode
          haskell-mode
          ruby-mode
          rust-mode
          go-mode
          emacs-lisp-mode
          graphviz-dot-mode) . grammatical-edit-mode)
  :bind (:map grammatical-edit-mode-map
              ("(" . grammatical-edit-open-round)
              ("[" . grammatical-edit-open-bracket)
              ("{" . grammatical-edit-open-curly)
              (")" . grammatical-edit-close-round)
              ("]" . grammatical-edit-close-bracket)
              ("}" . grammatical-edit-close-curly)
              ("%" . grammatical-edit-match-paren)
              ("=" . grammatical-edit-equal)
              ("SPC" . grammatical-edit-space)
              ("RET" . grammatical-edit-newline)
              ("M-o" . grammatical-edit-backward-delete)
              ("C-d" . grammatical-edit-forward-delete)
              ("C-k" . grammatical-edit-kill)
              ("M-)" . grammatical-edit-unwrap)
              ("M-p" . grammatical-edit-jump-right)
              ("M-n" . grammatical-edit-jump-left)))

(use-package elec-pair
  :hook (((org-mode
           markdown-mode
           LaTeX-mode
           prog-mode) . (lambda ()
                          (electric-pair-mode)
                          (electric-indent-mode)))
         ((minibuffer-inactive-mode) . (lambda ()
                                         (electric-pair-local-mode -1)))))

(use-package paren
  :config
  (show-paren-mode 1))

(provide 'init-pair)

;;; init-pair.el ends here
