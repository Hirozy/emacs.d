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
  :hook ((lisp-mode
          c++-mode
          c-mode
          python-mode
          go-mode
          emacs-lisp-mode
          graphviz-dot-mode) . awesome-pair-mode)
  :bind (:map awesome-pair-mode-map
              ("(" . awesome-pair-open-round)
              ("[" . awesome-pair-open-bracket)
              ("{" . awesome-pair-open-curly)
              (")" . awesome-pair-close-round)
              ("]" . awesome-pair-close-bracket)
              ("}" . awesome-pair-close-curly)
              ("%" . awesome-pair-match-paren)
              ("\"" . awesome-pair-double-quote)
              ("SPC" . awesome-pair-space)
              ("M-o" . awesome-pair-backward-delete)
              ("C-k" . awesome-pair-kill)
              ("M-\"" . awesome-pair-wrap-double-quote)
              ("M-]" . awesome-pair-wrap-bracket)
              ("M-}" . awesome-pair-wrap-curly)
              ("M-(" . awesome-pair-wrap-round)
              ("M-)" . awesome-pair-unwrap)
              ("M-p" . awesome-pair-jump-right)
              ("M-n" . awesome-pair-jump-left)
              ("M-:" . awesome-pair-jump-out-pair-and-newline)))

(use-package elec-pair
  :hook (((org-mode
           markdown-mode
           latex-mode) . electric-pair-mode)
         ((minibuffer-inactive-mode) . (lambda ()
                                         (electric-pair-mode -1))))
  :config
  (electric-pair-mode 1)
  (electric-indent-mode 1))

(use-package paren
  :config
  (show-paren-mode 1))

(provide 'init-pair)

;;; init-pair.el ends here
