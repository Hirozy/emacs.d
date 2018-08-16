(require 'package)

(setq require-package-list '())

(defun require-packages (package-list)
  ;; fetch the list of packages available 
  (unless package-archive-contents
    (package-refresh-contents))

  (setq require-package-list
        (append require-package-list
                package-list))
  
  ;; install the missing packages
  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package))))

(require-packages '(use-package))

(provide 'init-packages)
