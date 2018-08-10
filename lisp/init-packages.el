(require 'package)

(setq package-list package-selected-packages)

(defun require-packages (package-list)
  ; fetch the list of packages available 
  (unless package-archive-contents
    (package-refresh-contents))
    
  ; install the missing packages
  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package))))

(require-packages '(use-package))
(require-packages package-list)

(provide 'init-packages)