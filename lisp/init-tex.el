;;; init-tex.el --- tex-mode configuration

;;; Commentary:
;;
;; tex-mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(auctex
                    auctex-latexmk
                    biblio-core
                    biblio
                    cdlatex))

(use-package tex
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook (LaTeX-mode . (lambda ()
                        (add-to-list 'TeX-command-list
                                     '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
                        (setq-local TeX-command-default "XeLaTeX")
                        (turn-on-auto-fill)))

  :config
  (use-package tex-buf
    :init
    (setq TeX-show-compilation nil
          TeX-save-query nil))

  (use-package auctex-latexmk
    ;; tlmgr install latexmk
    :config
    (auctex-latexmk-setup))

  (use-package cdlatex
    :hook (LaTeX-mode . turn-on-cdlatex)))

(provide 'init-tex)

;;; init-tex.el ends here
