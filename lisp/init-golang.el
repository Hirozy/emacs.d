;;; init-golang.el -- golang support  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; golang support
;;

;;; Code:

(use-package go-mode
  :defer t)

(use-package go-playground
  :diminish
  :commands go-playground)

(provide 'init-golang)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-golang.el ends here
