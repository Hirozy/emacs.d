;;; init-packages.el --- Packages manager configuration

;;; Commentary:
;;
;; Packages manager configuration
;;

;;; Require
(require 'package)

;;; Code:

(defvar require-package-list '())
(defvar defined/package-refresh-flag nil)

(defun require-packages (package-list)
  "Fetch the list of packages available, PACKAGE-LIST is the list you want to install."
  (setq require-package-list
        (append require-package-list
                package-list))

  ;; install the missing packages
  (dolist (package package-list)
    (unless (or (package-installed-p package) (package-built-in-p package))
      (unless defined/package-refresh-flag
        (package-refresh-contents)
        (setq defined/package-refresh-flag t))
      (package-install package))))

(unless (version< emacs-version "28.0")
  (setq package-native-compile t))

(require-packages '(use-package))

(provide 'init-packages)

;;; init-packages.el ends here
