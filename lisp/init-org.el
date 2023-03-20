;;; init-org.el --- org mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; org mode configuration
;;

;;; Code:

(defun defined/org-without-confirm-babel-evaluate (lang body)
  "Org without confirm with LANG BODY."
  (not (or (string= lang "dot")
           (string= lang "gnuplot")
           (string= lang "python"))))

(use-package org
  :defer t
  :hook ((org-mode . visual-line-mode)
         (org-mode . eldoc-mode)
         (org-mode . (lambda ()
                       (setq-local lsp-diagnostics-provider :none))))
  :config
  (setq org-support-shift-select t
        ;; always display inline images
        org-startup-with-inline-images t
        ;; fontify code in code blocks
        org-src-fontify-natively t
        ;; default is nil, when non-nil, source
        ;; code is aligned with the leftmost column
        org-src-preserve-indentation t
        org-export-with-sub-superscripts nil
        org-confirm-babel-evaluate #'defined/org-without-confirm-babel-evaluate)

  ;; https://orgmode.org/worg/org-contrib/babel/languages.html
  ;; https://orgmode.org/manual/Languages.html#Languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (R . t)
     (awk . t)
     (calc . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (haskell . t)
     (latex . t)
     (lisp . t)
     (lua . t)
     (matlab . t)
     (octave . t)
     (org . t)
     (perl . t)
     (python . t)
     (ruby . t)
     (sed . t)
     (shell . t)
     (sql . t)
     (table . t)))

  (use-package ob-core
    :hook (org-babel-after-execute . org-redisplay-inline-images))

  (use-package org-shell-cat
    :commands org-copy-to-shell-cat
    :hook ((org-mode . org-babel-header-expand-shell-cat))
    :bind(:map org-mode-map
               ("C-c c" . org-copy-to-shell-cat)))

  (use-package org-tempo)

  (use-package ob-python
    :defer t
    :config
    (setq org-babel-python-command "python3"))

  (use-package ox-html
    :defer t
    :config
    (setq org-html-htmlize-output-type 'css))

  (use-package ox-latex
    :defer t
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
            "xelatex -interaction nonstopmode -output-directory %o %f"))))

(use-package org-roam
  :defer t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :after org-roam
  :diminish
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package org-download
  :hook ((org-mode
          dired-mode) . org-download-enable)
  :config
  (setq org-download-method 'attach))

(use-package valign
  :after org-mode
  :if (display-graphic-p)
  :hook (org-mode . valign-mode))

(provide 'init-org)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-org.el ends here
