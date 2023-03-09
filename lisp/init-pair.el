;;; init-pair.el --- Pair configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Pair configuration
;;

;;; Code:

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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
  :custom-face
  (show-paren-match ((t (:background "gray50" :foreground "gray100"))))
  :hook (after-init . show-paren-mode))

(use-package puni
  :defer t)

(provide 'init-pair)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-pair.el ends here
