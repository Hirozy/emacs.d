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

(setq org-support-shift-select t)

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

(setq org-babel-python-command "python3")

(add-to-list 'org-latex-minted-langs
             '(ipython "ipython3"))

;; always display inline images
;; https://orgmode.org/manual/In_002dbuffer-settings.html
(setq org-startup-with-inline-images t)

(add-hook 'org-babel-after-execute-hook
          'org-redisplay-inline-images)

(use-package ob-ipython)

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

;; fontify code in code blocks
(setq org-src-fontify-natively t)
(setq org-html-htmlize-output-type 'css)

(provide 'init-org)

;;; init-org.el ends here
