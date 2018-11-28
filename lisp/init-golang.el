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
                    go-guru
                    gotest))

(use-package company-go
  :hook
  (go-mode . (lambda ()
               (set (make-local-variable 'company-backends) '(company-go))
               (company-mode))))

(defun defined/go-file-run-in-shell ()
  "Run python file in async shell."
  (interactive)
  (save-buffer)
  (defined/kill-async-shell)
  (async-shell-command
   (format "go run %s" buffer-file-name)))

(provide 'init-golang)

;;; init-golang.el ends here
