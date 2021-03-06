;;; init-configs.el --- Misc configuration

;;; Commentary:
;;
;; Misc configuration
;;

;;; Code:

(setq-default
 ;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
 ;; stop creating backup~ files
 make-backup-files nil
 ;; stop creating #autosave# files
 auto-save-default nil
 create-lockfiles nil
 visible-bell 1
 ;; enabled word wrap
 truncate-lines 1
 tramp-default-method "ssh"
 inhibit-startup-screen t
 display-line-numbers 'relative)

;; show cursor position within line
(column-number-mode 1)

;; disabled tool bar
(tool-bar-mode -1)

;; enabled mouse support in terminal
(xterm-mouse-mode 1)

(global-set-key (kbd "<mouse-4>") (lambda ()
                                    (interactive)
                                    (scroll-down 3)))

(global-set-key (kbd "<mouse-5>") (lambda ()
                                    (interactive)
                                    (scroll-up 3)))

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(put 'scroll-left 'disabled nil)

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|127\\.*\\)")
        ("http" . "127.0.0.1:6152")
        ("https" . "127.0.0.1:6152")
        ("ftp" . "127.0.0.1:6152")))

(provide 'init-configs)

;;; init-configs.el ends here
