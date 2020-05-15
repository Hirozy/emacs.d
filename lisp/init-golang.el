;;; init-golang.el -- golang support

;;; Commentary:
;;
;; golang support
;;

;;; Require
(require 'init-packages)
(require 'init-defined)

;;; Code:

(require-packages '(company-go
                    go-mode
                    go-rename
                    go-guru
                    gotest))

(use-package company-go
  :hook (go-mode . (lambda ()
                     (set (make-local-variable 'company-backends) '(company-go)))))

(defun defined/go-file-run-in-shell ()
  "Run Golang file in async shell."
  (interactive)
  (save-buffer)
  (defined/kill-async-shell)
  (async-shell-command
   (format "go run %s" buffer-file-name)))

(provide 'init-golang)

;;; init-golang.el ends here
