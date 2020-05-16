;;; init-c-cpp.el --- c-mode/c++-mode configuratione

;;; Commentary:
;;
;; c-mode/c++-mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(setq-default c-basic-offset 4)

(add-hook 'c++-mode-hook
          (lambda ()
            (setq flycheck-gcc-language-standard "c++17"
                  flycheck-clang-language-standard "c++17")))

(provide 'init-c-cpp)

;;; init-c-cpp.el ends here
