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
                    cdlatex
                    company-math))

(use-package tex
  :hook (LaTeX-mode . (lambda ()
                        (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))))

  :init
  (setq TeX-command-default "XeLaTeX")
  (setq TeX-command-Show "XeLaTeX")

  :config
  (use-package tex-buf
    :init
    ;; (setq TeX-show-compilation t)
    (setq TeX-save-query nil))

  (use-package auctex-latexmk
    ;; tlmgr install latexmk
    :init
    (auctex-latexmk-setup))
  
  (use-package cdlatex
    :hook (LaTeX-mode . turn-on-cdlatex)))

(use-package latex-extra
  :hook (LaTeX-mode . latex-extra-mode))

(use-package company-auctex
  :init
  (company-auctex-init))

(use-package company-math
  :hook (LaTeX-mode . (lambda ()
  (add-to-list 'company-backends 'company-math-symbols-unicode))))

(provide 'init-tex)

;;; init-tex.el ends here
