(require-packages '(org-plus-contrib))

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

(provide 'init-org)
