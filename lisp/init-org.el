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
  :bind (:map org-mode-map
              ("C-," . org-mark-ring-goto)
              ("M-N" . org-next-visible-heading)
              ("M-P" . org-previous-visible-heading)
              ("M-U" . org-up-element)
              ("M-D" . org-down-element)
              ("M-H" . org-previous-link)
              ("M-J" . org-next-link)
              ("M-K" . org-previous-block)
              ("M-L" . org-next-block))
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
    (setq org-html-htmlize-output-type 'css)))

(use-package org-preview-html
  :after org
  :commands org-preview-html-mode
  :bind (("<f6>" . org-preview-html-mode)))

(use-package denote
  :config
  (setq denote-prompts '(title)))

(provide 'init-org)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-org.el ends here
