;;; init-golang.el -- golang support

;;; Commentary:
;;
;; golang support
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(company-go
                    go-mode
                    go-rename
                    go-guru))

(use-package company-go
  :hook
  (go-mode . (lambda ()
               (set (make-local-variable 'company-backends) '(company-go))
               (company-mode))))

(provide 'init-golang)

;;; init-golang.el ends here
