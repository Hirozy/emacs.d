;;; init-configs.el --- Misc configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Misc configuration
;;

;;; Code:

(setq-default
 ;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
 ;; Stop creating backup~ files
 make-backup-files nil
 ;; Stop creating #autosave# files
 auto-save-default nil
 ;; Don’t compact font caches during GC
 inhibit-compacting-font-caches t
 create-lockfiles nil
 visible-bell t
 ;; Enabled word wrap
 truncate-lines t
 tramp-default-method "ssh"
 inhibit-startup-screen t
 ;; Increase how much is read from processes in a single chunk
 ;; default is 4kb, now is 64kb
 read-process-output-max #x10000)

;; Show cursor position within line
(column-number-mode)

;; Disabled tool bar
(tool-bar-mode -1)

(if (version< emacs-version "29.0")
    (progn (global-set-key (kbd "<mouse-4>") (lambda ()
                                               (interactive)
                                               (scroll-down 3)))
           (global-set-key (kbd "<mouse-5>") (lambda ()
                                               (interactive)
                                               (scroll-up 3))))
  (progn (pixel-scroll-precision-mode 1)
         (setq-default display-line-numbers-width 3)))


(require 'view)
(global-set-key (kbd "C-v") 'View-scroll-half-page-forward)
(global-set-key (kbd "M-v") 'View-scroll-half-page-backward)
(global-unset-key (kbd "C-<wheel-up>"))
(global-unset-key (kbd "C-<wheel-down>"))

;; Change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(put 'scroll-left 'disabled nil)

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|127\\.*\\)")
        ("http" . "127.0.0.1:6152")
        ("https" . "127.0.0.1:6152")
        ("ftp" . "127.0.0.1:6152")))

(provide 'init-configs)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-configs.el ends here
