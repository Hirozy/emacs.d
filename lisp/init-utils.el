;;; init-utils.el --- Utils configuration  -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Utils configuration
;;

;;; Code:

(use-package which-key
  :hook (after-init . which-key-mode)
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 1
        which-key-popup-type 'minibuffer))

(use-package avy
  :bind (("C-x C-SPC" . avy-pop-mark)
         ("C-;" . avy-goto-word-1)
         ("M-z" . avy-goto-word-1)))

(use-package winner
  :hook (after-init . winner-mode))

(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'abbrev-mode)
  (diminish 'auto-revert-mode))

(use-package treemacs
  :bind ("s-t" . treemacs-select-window)
  :config
  (use-package treemacs-projectile
    :after treemacs projectile)

  (use-package treemacs-icons-dired
    :if (memq window-system '(mac ns x))
    :config
    (treemacs-icons-dired-mode))

  (use-package treemacs-magit
    :after treemacs magit))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))

;; Highlight the current line
(use-package hl-line
  :custom-face
  (hl-line ((t (:underline "dodger blue"))))
  :hook (((eshell-mode shell-mode term-mode vterm-mode) .
          (lambda () (setq-local hl-line-mode nil))))
  :config
  (global-hl-line-mode))

(use-package goto-chg :defer t)

(use-package uuidgen :defer t)

(use-package open-newline :defer t)

(provide 'init-utils)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-utils.el ends here
