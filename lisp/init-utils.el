;;; init-utils.el --- Utils configuration  -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Utils configuration
;;

;;; Code:

(use-package which-key
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1
        which-key-popup-type 'minibuffer)
  (which-key-mode 1))

(use-package avy
  :bind (("C-x C-SPC" . avy-pop-mark)
         ("C-;" . avy-goto-word-1)
         ("M-z" . avy-goto-word-1)))

(use-package winner
  :hook (after-init . winner-mode))

(use-package zoom
  :hook (after-init . zoom-mode)
  :custom
  (zoom-size '(0.618 . 0.618)))

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
  :hook ((after-init . global-hl-line-mode)
         ((eshell-mode shell-mode term-mode vterm-mode) .
          (lambda () (setq-local global-hl-line-mode nil)))))

(use-package awesome-tab
  :config
  (setq awesome-tab-display-icon nil
        awesome-tab-height 120
        awesome-tab-show-tab-index t)

  (defun defined/awesome-tab-hide-tab (x)
    "Hide tabs"
    (let ((name (format "%s" x)))
      (or
       ;; Current window is not dedicated window.
       (window-dedicated-p (selected-window))

       (string-prefix-p "*ccls" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p "*pyright" name)
       (string-prefix-p "*which" name)
       (string-prefix-p "*transient" name)
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name)))
       )))

  (defun defined/awesome-tab-buffer-groups ()
    "`awesome-tab-buffer-groups' control buffers' group rules.
Group awesome-tab with mode if buffer is derived from
`eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `awesome-tab-get-group-name' with project name."
    (list
     (cond
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode)))
       "Emacs")
      ((derived-mode-p 'eshell-mode)
       "EShell")
      ((derived-mode-p 'dired-mode)
       "Dired")
      (t
       (awesome-tab-get-group-name (current-buffer))))))
  (setq awesome-tab-hide-tab-function #'defined/awesome-tab-hide-tab)
  (setq awesome-tab-buffer-groups-function #'defined/awesome-tab-buffer-groups)
  (awesome-tab-mode t))

(use-package goto-chg)
(use-package uuidgen)
(use-package open-newline)

(provide 'init-utils)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-utils.el ends here
