;;; init-packages.el --- Packages manager configuration

;;; Commentary:
;;
;; Packages manager configuration
;;

;;; Code:

(require 'package)

(defvar require-package-list '())
(defvar defined/package-refresh-flag nil)

(defun require-packages (package-list)
  "Fetch the list of packages available, PACKAGE-LIST is the list you want to install."
  (unless package-archive-contents
    (package-refresh-contents))

  (setq require-package-list
        (append require-package-list
                package-list))
  
  ;; install the missing packages
  (dolist (package package-list)
    (unless (package-installed-p package)
      (unless defined/package-refresh-flag
        (package-refresh-contents)
        (setq defined/package-refresh-flag t))
      (package-install package))))

(require-packages '(use-package))

(provide 'init-packages)

;;; init-packages.el ends here
