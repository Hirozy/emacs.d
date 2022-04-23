;;; init-golang.el -- golang support -*- lexical-binding: t -*-

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

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-golang.el ends here
