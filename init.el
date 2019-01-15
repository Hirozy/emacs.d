;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Figure out the path to our .emacs.d by getting the path part of the
;; current file (`init.el`).
(defvar dotfiles-dir (file-name-directory
                      (or (buffer-file-name) (file-chase-links load-file-name))))

(add-to-list 'load-path (concat dotfiles-dir "lisp"))
(add-to-list 'load-path (concat dotfiles-dir "site-lisp"))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)
;; Keep emacs custom in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(require 'init-packages)
(require 'init-configs)
(require 'init-theme)
(require 'init-keymap)
(require 'init-exec-path)
(require 'init-user-defined)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-org)
(require 'init-ivy)
(require 'init-projectile)
(require 'init-completion)
(require 'init-editing)
(require 'init-pair)
(require 'init-utils)
(require 'init-visual)
(require 'init-python)
(require 'init-markdown)
(require 'init-c-cpp)
(require 'init-tags)
(require 'init-tex)
(require 'init-plot)
(require 'init-lua)
(require 'init-golang)
(require 'init-evil)

(require 'init-hydra)
(require 'init-end)

(provide 'init)

;;; init.el ends here
