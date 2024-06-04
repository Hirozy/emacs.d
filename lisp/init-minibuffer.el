;;; init-minibuffer.el --- minibuffer configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; minibuffer configuration
;;

;;; Code:

(use-package vertico
  :hook ((after-init . vertico-mode))
  :bind (:map vertico-map
              ("?" . minibuffer-completion-help)
              ("C-v" . vertico-scroll-up)
              ("M-v" . vertico-scroll-down)
              ("<tab>" . vertico-insert)
              ("M-RET" . vertico-exit-input))
  :config
  (vertico-indexed-mode))

(use-package vertico-directory
  :after vertico
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package consult
  :demand t
  :defines (consult-project-root-function)
  :bind (;; remap projectile
         ([remap projectile-ripgrep] . consult-ripgrep)
         ([remap projectile-grep] . consult-grep)
         ([remap projectile-recentf] . consult-projectile-recentf)
         ([remap projectile-switch-to-buffer] . consult-projectile-switch-to-buffer)
         ([remap projectile-find-file] . consult-projectile)
         ([remap projectile-find-dir] . consult-projectile-find-dir)
         ([remap projectile-switch-project] . consult-projectile-switch-project)
         ;; isearch
         ("C-s" . consult-line)
         ("C-S-s" . consult-line-multi)
         ;; buffer
         ("C-x b" . (lambda ()
                      (interactive)
                      (if (projectile-project-root)
                          (consult-project-buffer)
                        (consult-buffer))))
         ("C-x C-b" . consult-buffer))

  :config
  (setq consult-project-root-function 'projectile-project-root
        consult-async-refresh-delay 0
        consult-async-input-throttle 0
        consult-async-input-debounce 0
        ;; disable all preview
        consult-preview-key "M-."
        xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package consult-dir
  :commands consult-dir
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package consult-flycheck
  :commands consult-flycheck
  :bind ("C-c l l" . consult-flycheck))

(use-package consult-flymake
  :commands consult-flymake
  :bind ("C-c l ;" . consult-flymake))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package embark
  :bind (("C-." . embark-act)
         ("M-." . embark-dwim)
         (("C-h B" . embark-bindings))))

(use-package embark-consult
  :after (embark consult))

(provide 'init-minibuffer)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-minibuffer.el ends here
