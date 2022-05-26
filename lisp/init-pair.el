;;; init-pair.el --- Pair configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Pair configuration
;;

;;; Code:

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package awesome-pair
  :hook ((prog-mode) . awesome-pair-mode)
  :bind (([remap kill-line] . awesome-pair-kill)
         :map awesome-pair-mode-map
         ("%" . awesome-pair-match-paren)
         ;; ("SPC" . awesome-pair-space)
         ;; ("RET" . awesome-pair-newline)
         ("M-o" . awesome-pair-backward-delete)
         ("M-p" . awesome-pair-jump-right)
         ("M-n" . awesome-pair-jump-left)
         ("M-;" . awesome-pair-jump-out-pair-and-newline)))

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

(provide 'init-pair)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-pair.el ends here
