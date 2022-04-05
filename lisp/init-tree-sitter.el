;;; init-tree-sitter.el --- Tree sitter configuration

;;; Commentary:
;;
;; Tree sitter configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(tree-sitter
                    tree-sitter-langs))

(use-package tree-sitter
  :init
  (global-tree-sitter-mode))

(provide 'init-tree-sitter)

;;; init-tree-sitter.el ends here
