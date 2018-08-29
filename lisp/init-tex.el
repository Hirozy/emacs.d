(require-packages '(auctex
                    company-auctex
                    auctex-latexmk
                    biblio-core
                    biblio))

(add-hook 'LaTeX-mode-hook 
          (lambda()
             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
             (setq TeX-command-default "XeLaTeX")
             (setq TeX-save-query nil)
             (setq TeX-show-compilation t)))

(use-package company-auctex
  :init
  (company-auctex-init))

(provide 'init-tex)
