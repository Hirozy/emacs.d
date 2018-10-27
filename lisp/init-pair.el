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
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package elec-pair
  :init
  (setq electric-pair-pairs '(
                              (?\" . ?\")
                              (?\( . ?\))
                              (?\{ . ?\})
                              (?\` . ?\`)
                              ))
  :config
  (electric-indent-mode 1)
  (electric-pair-mode 1))

(use-package paren
  :config
  (show-paren-mode 1))

(provide 'init-pair)

;;; init-pair.el ends here
