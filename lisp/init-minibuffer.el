;;; init-minibuffer.el --- minibuffer configuration

;;; Commentary:
;;
;; minibuffer configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(counsel
                    counsel-tramp
                    counsel-projectile
                    ivy
                    ivy-rich
                    ivy-yasnippet
                    ivy-prescient
                    ivy-xref
                    swiper
                    orderless
                    all-the-icons-ivy-rich))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package ivy
  :diminish ivy-mode
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . ivy-switch-buffer)
         ("C-x C-b" . ivy-switch-buffer))
  :init
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . orderless-ivy-re-builder))
        ;; disable ivy prefixes
        ivy-initial-inputs-alist nil)
  :config
  (add-to-list 'ivy-highlight-functions-alist
               '(orderless-ivy-re-builder . orderless-ivy-highlight))
  (ivy-mode 1))

(use-package counsel
  :diminish counsel-mode
  :bind (("C-x C-f" . counsel-find-file)
         ("C-c l" . counsel-flycheck)
         ("C-." . counsel-semantic-or-imenu))
  :config
  (counsel-mode 1))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

(use-package ivy-prescient
  :after ivy
  :custom
  (ivy-prescient-enable-filtering nil)
  (ivy-prescient-enable-sorting t)
  :config
  (setq ivy-prescient-sort-commands
        '(:not swiper swiper-isearch ivy-switch-buffer
               ivy-resume ivy--restore-session lsp-ivy-workspace-symbol
               counsel-grep counsel-git-grep counsel-rg counsel-ag
               counsel-ack counsel-fzf counsel-pt counsel-imenu
               counsel-yank-pop counsel-recentf counsel-buffer-or-recentf))
  (ivy-prescient-mode))

(use-package ivy-xref
  :after ivy
  :init
  (setq xref-show-definitions-function #'ivy-xref-show-defs
        xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (counsel-projectile-mode 1))

(provide 'init-minibuffer)

;;; init-minibuffer.el ends here
