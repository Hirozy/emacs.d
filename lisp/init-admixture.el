;;; init-admixture.el --- Mixed languages

;;; Commentary:
;;
;; A mode file that mixes multiple programming languages
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(yaml-mode
                    cmake-mode
                    dockerfile-mode
                    lua-mode
                    fish-mode))

(use-package lua-mode
  :mode "\\.lua\\'")

(provide 'init-admixture)

;;; init-admixture.el ends here
