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
                    ivy
                    ivy-rich
                    ivy-yasnippet
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
         ("C-." . counsel-semantic-or-imenu))
  :config
  (counsel-mode 1))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

(provide 'init-minibuffer)

;;; init-minibuffer.el ends here
