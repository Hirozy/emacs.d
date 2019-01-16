;;; init-org.el --- org mode configuration

;;; Commentary:
;;
;; org mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(org-plus-contrib
                    ob-ipython
                    htmlize))

(use-package org
  :config
  (setq org-support-shift-select t
        ;; always display inline images
        ;; https://orgmode.org/manual/In_002dbuffer-settings.html
        org-startup-with-inline-images t
        ;; fontify code in code blocks
        org-src-fontify-natively t)
  ;; https://orgmode.org/worg/org-contrib/babel/languages.html
  ;; https://orgmode.org/manual/Languages.html#Languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (ipython . t)
     (C . t)
     (calc . t)
     (emacs-lisp . t)
     (octave . t)
     (sed . t)
     (awk . t)
     (matlab . t)
     (R . t)
     (shell . t)))

  (use-package ob-core
    :hook (org-babel-after-execute . org-redisplay-inline-images))
  
  (use-package ob-python
    :config
    (setq org-babel-python-command "python3"))

  (use-package ob-ipython)

  (use-package ox-latex
    :config
    (add-to-list 'org-latex-minted-langs
                 '(ipython "ipython3")))
  (use-package ox-html
    :config
    (setq org-html-htmlize-output-type 'css)))

(use-package ox-latex
  :config
  (add-to-list 'org-latex-classes
               '("article"
                 "\\documentclass[11pt]{article}
\\usepackage{xltxtra,xunicode}
\\usepackage{tikz}
\\usetikzlibrary{arrows,shapes,chains}
\\usepackage{amsmath}
\\usepackage{listings}
\\usepackage[slantfont,boldfont]{xeCJK}
\\setCJKmainfont{Kai}
\\setCJKmonofont{Hei}
\\setsansfont{Trebuchet MS}
\\usepackage{indentfirst}
\\setlength{\\parindent}{2em}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-export-in-background t)
  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f")))

(provide 'init-org)

;;; init-org.el ends here
