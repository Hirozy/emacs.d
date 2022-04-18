;;; init-minibuffer.el --- minibuffer configuration

;;; Commentary:
;;
;; minibuffer configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(vertico
                    consult
                    consult-flycheck
                    consult-yasnippet
                    consult-projectile
                    orderless
                    marginalia
                    savehist
                    embark))

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

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package savehist
  :after vertico
  :hook (after-init . savehist-mode))

(use-package consult
  :defines (consult-project-root-function)
  :hook ((after-init . recentf-mode))
  :bind (;; remap projectile
         ([remap projectile-ripgrep] . consult-ripgrep)
         ([remap projectile-grep] . consult-grep)
         ([remap projectile-recentf] . consult-projectile-recentf)
         ([remap projectile-switch-to-buffer] . consult-project-buffer)
         ;; ([remap projectile-find-file] . consult-projectile-find-file)
         ;; ([remap projectile-find-dir] . consult-projectile-find-dir)
         ;; remap yasnippet
         ([remap yas-insert-snippet] . consult-yasnippet)
         ([remap yas-visit-snippet-file] . consult-yasnippet-visit-snippet-file)
         ;; consult keymap
         ("C-c l" . consult-flycheck))

  :config
  (setq consult-project-root-function 'projectile-project-root
        consult-async-refresh-delay 0
        consult-async-input-throttle 0
        consult-async-input-debounce 0)
  (consult-customize consult-ripgrep
                     consult-git-grep
                     consult-grep
                     consult-bookmark
                     consult-recent-file
                     consult-xref
                     consult-theme
                     consult--source-bookmark
                     consult--source-recent-file
                     consult--source-project-recent-file
                     :preview-key nil))

(use-package orderless
  :after vertico
  :init
  (setq completion-styles '(substring orderless)))

(use-package embark
  :after vertico
  :bind (:map vertico-map
              ("C-c C-o" . embark-export)
              ("C-c C-c" . embark-act)))

(provide 'init-minibuffer)

;;; init-minibuffer.el ends here
