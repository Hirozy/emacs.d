;;; init-golang.el -- golang support

;;; Commentary:
;;
;; golang support
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(go-mode
                    go-rename
                    go-guru
                    gotest))

(provide 'init-golang)

;;; init-golang.el ends here
