;;; init-c-cpp.el --- c-mode/c++-mode configuratione

;;; Commentary:
;;
;; c-mode/c++-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'init-defined)

;;; Code:

(setq-default c-basic-offset 4)

(setq compilation-finish-functions 'defined/compile-finished)
(defvar defined/build-successful-flag nil)
(defvar defined/current-buffer-file-name)

(provide 'init-c-cpp)

;;; init-c-cpp.el ends here
