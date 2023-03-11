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
  :hook (((text-mode
           conf-mode
           prog-mode) . (lambda ()
           (electric-pair-mode)
           (electric-indent-mode)))
         ((minibuffer-inactive-mode) . (lambda ()
                                         (electric-pair-local-mode -1)))
         ((minibuffer-inactive-mode
           org-mode) . (lambda ()
           (electric-indent-local-mode -1)))
         (org-mode . (lambda ()
                       (add-function :before-until (local 'electric-pair-inhibit-predicate)
                                     (lambda (c) (eq c ?<)))
                       (let ((org-elec-pairs '((?/ . ?/)
                                               (?_ . ?_)
                                               (?$ . ?$)
                                               (?~ . ?~))))
                         (setq-local electric-pair-pairs
                                     (append electric-pair-pairs org-elec-pairs))
                         (setq-local electric-pair-text-pairs
                                     (append electric-pair-text-pairs org-elec-pairs)))))))

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
