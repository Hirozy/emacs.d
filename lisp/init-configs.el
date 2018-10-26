;; Show Line Numbers
;; Use linum instead
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))

;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
;; stop creating backup~ files
(setq make-backup-files nil)
;; stop creating #autosave# files
(setq auto-save-default nil)

(setq create-lockfiles nil)

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(put 'scroll-left 'disabled nil)

;; disabled word wrap
(setq-default truncate-lines nil)

;; display the current column number
(setq column-number-mode t)

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|127.*\\)")
        ("http" . "127.0.0.1:6152")
        ("https" . "127.0.0.1:6152")
        ("ftp" . "127.0.0.1:6152")))

(provide 'init-configs)
