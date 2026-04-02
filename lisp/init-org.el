;;; init-org.el --- org mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; org mode configuration
;;

;;; Code:
(require 'transient)
(require 'consult)

(defvar defined/org-without-confirm-babel
  '("dot"
    "gnuplot"
    "python"
    "plantuml"
    )
  "List of languages that should not prompt for confirmation when evaluating.")

(use-package org
  :defer t
  :hook ((org-mode . visual-line-mode)
         (org-mode . eldoc-mode)
         (org-mode . (lambda ()
                       (setq-local lsp-diagnostics-provider :none))))
  :bind (:map org-mode-map
              ("C-," . org-mark-ring-goto))

  :custom
  (org-support-shift-select t)
  (org-startup-with-inline-images t) ;; always display inline images
  (org-src-fontify-natively t)  ;; fontify code in code blocks
  (org-src-preserve-indentation t)  ;;  source code is aligned with the leftmost column
  (org-export-with-sub-superscripts nil)
  (org-confirm-babel-evaluate (lambda (lang body)
                                (not (member lang defined/org-without-confirm-babel))))

  :config
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
     (plantuml . t)
     (ruby . t)
     (sed . t)
     (sql . t)
     (table . t))))

(use-package ob-core
  :after org
  :hook (org-babel-after-execute . org-redisplay-inline-images))

(use-package org-shell-cat
  :after org
  :commands org-copy-to-shell-cat
  :hook (org-mode . org-babel-header-expand-shell-cat)
  :bind (:map org-mode-map
              ("C-c c" . org-copy-to-shell-cat)))

(use-package denote
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c d" . denote-open-or-create-with-command))
  :config
  (denote-rename-buffer-mode))

(use-package consult-denote
  :after denote
  :config
  (consult-denote-mode))

(provide 'init-org)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-org.el ends here
