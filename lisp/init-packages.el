(require 'package)

(setq package-list package-selected-packages)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))
  
; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(provide 'init-packages)