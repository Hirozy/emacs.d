;;; init-tex.el --- tex-mode configuration

;;; Commentary:
;;
;; tex-mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(auctex
                    company-auctex
                    auctex-latexmk
                    biblio-core
                    biblio
                    latex-extra
                    cdlatex))

(use-package LaTeX-mode
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook (LaTeX-mode . (lambda ()
                        (add-to-list 'TeX-command-list
                                     '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
                        (setq-local TeX-command-default "XeLaTeX")))

  :config
  (use-package tex-buf
    :init
    (setq TeX-show-compilation nil)
    (setq TeX-save-query nil))

  (use-package auctex-latexmk
    ;; tlmgr install latexmk
    :config
    (auctex-latexmk-setup))
  
  (use-package cdlatex
    :hook (LaTeX-mode . turn-on-cdlatex))
  
  (use-package company-auctex
    :config
    (company-auctex-init)))

(use-package latex-extra
  :hook (LaTeX-mode . latex-extra-mode))

(provide 'init-tex)

;;; init-tex.el ends here
