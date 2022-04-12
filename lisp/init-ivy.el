;;; init-ivy.el --- ivy configuration

;;; Commentary:
;;
;; ivy configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(counsel
                    counsel-tramp
                    ivy
                    ivy-rich
                    ivy-yasnippet
                    ivy-prescient
                    swiper
                    all-the-icons-ivy-rich))

(use-package ivy
  :diminish ivy-mode
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . ivy-switch-buffer)
         ("C-x C-b" . ivy-switch-buffer))
  :init
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))
        ;; disable ivy prefixes
        ivy-initial-inputs-alist nil)
  :config
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

(use-package ivy-prescient
  :after (counsel ivy)
  :config
  (setq ivy-prescient-enable-sorting nil)
  (ivy-prescient-mode))

(provide 'init-ivy)

;;; init-ivy.el ends here
