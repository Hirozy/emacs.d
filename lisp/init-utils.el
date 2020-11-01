;;; init-utils.el --- Utils configuration

;;; Commentary:
;;
;; Utils configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(all-the-icons
                    avy
                    diminish
                    doom-modeline
                    golden-ratio
                    highlight-indent-guides
                    treemacs
                    treemacs-all-the-icons
                    treemacs-icons-dired
                    treemacs-magit
                    treemacs-projectile
                    uuidgen
                    vterm
                    ztree
                    which-key))

(use-package which-key
  :diminish which-key-mode
  :init
  ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
  ;; zero might cause issues so a non-zero value is recommended.
  (setq which-key-idle-delay 0.1
        which-key-popup-type 'minibuffer)
  :config
  (which-key-mode 1))

(use-package avy
  :bind (("C-x C-SPC" . avy-pop-mark)
         ("C-:" . avy-goto-char)))

(use-package winner
  :hook (after-init . winner-mode))

;; The shell name is defined by `vterm-shell'
;; or `shell-file-name' (if set).
(use-package vterm)

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config
  (golden-ratio-mode 1))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))

(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'abbrev-mode))

(use-package doom-modeline
  :config
  (setq doom-modeline-project-detection 'projectile
        doom-modeline-major-mode-icon nil)
  (doom-modeline-mode 1))

(use-package treemacs
  :config
  (use-package treemacs-projectile
    :after treemacs projectile)

  (use-package treemacs-icons-dired
    :config
    (treemacs-icons-dired-mode))

  (use-package treemacs-magit
    :after treemacs magit))

(use-package uuidgen)

(use-package open-newline
  :load-path "site-lisp/open-newline")

(use-package awesome-tab
  :load-path "site-lisp/awesome-tab"
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
  (setq awesome-tab-hide-tab-function #'defined/awesome-tab-hide-tab)

  (defun defined/awesome-tab-buffer-groups ()
    "`awesome-tab-buffer-groups' control buffers' group rules.
Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
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
  (setq awesome-tab-buffer-groups-function #'defined/awesome-tab-buffer-groups)
  (awesome-tab-mode t))

(provide 'init-utils)

;;; init-utils.el ends here
