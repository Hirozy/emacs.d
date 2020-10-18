;;; init-org.el --- org mode configuration

;;; Commentary:
;;
;; org mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(org-plus-contrib
                    org-roam
                    org-roam-server
                    company-org-roam
                    htmlize))

(use-package org
  :hook (org-mode . visual-line-mode)
  :config
  (setq org-support-shift-select t
        ;; always display inline images
        org-startup-with-inline-images t
        ;; fontify code in code blocks
        org-src-fontify-natively t
        ;; default is nil, when non-nil, source
        ;; code is aligned with the leftmost column
        org-src-preserve-indentation t
        org-export-with-sub-superscripts nil)
  ;; https://orgmode.org/worg/org-contrib/babel/languages.html
  ;; https://orgmode.org/manual/Languages.html#Languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
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

  (use-package ox-latex)

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

(use-package valign
  :load-path "site-lisp/valign"
  :hook (org-mode . valign-mode))

(provide 'init-org)

;;; init-org.el ends here
