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
(require 'init-defun)
(require 'init-ivy)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-tree-sitter)
(require 'init-lsp)
(require 'init-org)
(require 'init-projectile)
(require 'init-completion)
(require 'init-editing)
(require 'init-tags)
(require 'init-pair)
(require 'init-utils)

(require 'init-python)
(require 'init-c-cpp)
(require 'init-golang)
(require 'init-haskell)

(require 'init-javascript)
(require 'init-tex)
(require 'init-markdown)
(require 'init-plot)

(require 'init-git)
(require 'init-admixture)
(require 'init-runner)
(require 'init-evil)

(require 'init-hydra)
(require 'init-postconfig)

(provide 'init)

;;; init.el ends here
