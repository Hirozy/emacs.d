;; Show Line Numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
;; stop creating backup~ files
(setq make-backup-files nil)
;; stop creating #autosave# files
(setq auto-save-default nil)

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|127.*\\)")))

(provide 'init-configs)
