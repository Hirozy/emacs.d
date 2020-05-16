;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Figure out the path to our .emacs.d by getting the path part of the
;; current file (`init.el`).
(defvar dotfiles-dir (file-name-directory
                      (or (buffer-file-name) (file-chase-links load-file-name))))

(add-to-list 'load-path (concat dotfiles-dir "lisp"))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)
;; Keep emacs custom in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(require 'init-configs)
(require 'init-packages)
(require 'init-exec-path)
(require 'init-theme)
(require 'init-defined)

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
(require 'init-lsp)
(require 'init-python)
(require 'init-markdown)
(require 'init-c-cpp)
(require 'init-tags)
(require 'init-tex)
(require 'init-plot)
(require 'init-golang)
(require 'init-evil)
(require 'init-git)

(require 'init-runner)
(require 'init-hydra)
(require 'init-end)

(provide 'init)

;;; init.el ends here
