;;; init-configs.el --- Misc configuration

;;; Commentary:
;;
;; Misc configuration
;;

;;; Code:

;; Show Line Numbers
;; Use linum instead
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))

(setq-default
 ;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
 ;; stop creating backup~ files
 make-backup-files nil
 ;; stop creating #autosave# files
 auto-save-default nil
 create-lockfiles nil
 ;; enabled word wrap
 truncate-lines nil)

;; enabled mouse support in terminal
(xterm-mouse-mode 1)
(global-set-key (kbd "<mouse-4>") 'scroll-down-3-lines)
(global-set-key (kbd "<mouse-5>") 'scroll-up-3-lines)

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(put 'scroll-left 'disabled nil)

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|127.*\\)")
        ("http" . "127.0.0.1:6152")
        ("https" . "127.0.0.1:6152")
        ("ftp" . "127.0.0.1:6152")))

(provide 'init-configs)

;;; init-configs.el ends here
