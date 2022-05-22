;;; init-pair.el --- Pair configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Pair configuration
;;

;;; Code:

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens-config
  :diminish smartparens-mode
  :hook (((lisp-mode
           lisp-interaction-mode
           c-mode
           c++-mode
           python-mode
           haskell-mode
           ruby-mode
           rust-mode
           lua-mode
           shell-script-mode
           emacs-lisp-mode
           graphviz-dot-mod) . (lambda ()
                                 (smartparens-mode)
                                 (smartparens-strict-mode)))))

(use-package elec-pair
  :defer t
  :hook (((org-mode
           markdown-mode
           LaTeX-mode
           prog-mode) . (lambda ()
           (electric-pair-mode)
           (electric-indent-mode)))
         ((minibuffer-inactive-mode) . (lambda ()
                                         (electric-pair-local-mode -1)))))

(use-package paren
  :hook (after-init . show-paren-mode))

(provide 'init-pair)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-pair.el ends here
