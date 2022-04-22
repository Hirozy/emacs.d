;;; init-packages.el --- Packages manager configuration

;;; Commentary:
;;
;; Packages manager configuration
;;

;;; Require
(require 'package)

;;; Code:

(eval-and-compile
  (add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
  (require 'borg)
  (borg-initialize))

(progn
  (require 'use-package)
  (setq use-package-verbose t))

(use-package dash)
(use-package eieio)

(use-package auto-compile
  :config
  (setq auto-compile-display-buffer nil
        auto-compile-mode-line-counter t
        auto-compile-source-recreate-deletes-dest t
        auto-compile-toggle-deletes-nonlib-dest t
        auto-compile-update-autoloads t))

(use-package epkg
  :defines (epkg-repository)
  :defer t
  :init (setq epkg-repository
              (expand-file-name "var/epkgs/" user-emacs-directory)))

(provide 'init-packages)

;;; init-packages.el ends here
