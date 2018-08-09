;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Figure out the path to our .emacs.d by getting the path part of the
;; current file (`init.el`).
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) (file-chase-links load-file-name))))

(add-to-list 'load-path (concat dotfiles-dir "lisp"))
(add-to-list 'load-path (concat dotfiles-dir "site-lisp"))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)
;; Keep emacs custom in separate file
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))
(require 'init-packages)
(require 'init-configs)
(require 'init-theme)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-helm)
(require 'init-completion)
(require 'init-python)
(require 'init-which-key)
(require 'init-visual)

(provide 'init)