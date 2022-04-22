;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(load-file (expand-file-name "early-init.el" user-emacs-directory))
;; Keep emacs custom in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(require 'init-configs)
(require 'init-packages)
(require 'init-basic)
(require 'init-exec-path)
(require 'init-theme)
(require 'init-defun)
(require 'init-minibuffer)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
;; (require 'init-tree-sitter)
;; (require 'init-lsp)
;; (require 'init-org)
(require 'init-projectile)
;; (require 'init-completion)
;; (require 'init-editing)
(require 'init-tags)
;; (require 'init-pair)
;; (require 'init-utils)

;; (require 'init-python)
;; (require 'init-c-cpp)
;; (require 'init-golang)
;; (require 'init-haskell)

;; (require 'init-javascript)
;; (require 'init-tex)
;; (require 'init-markdown)
;; (require 'init-plot)

(require 'init-git)
;; (require 'init-admixture)
;; (require 'init-runner)
;; (require 'init-evil)

;; (require 'init-hydra)

(provide 'init)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init.el ends here
