;;; init-tree-sitter.el --- Tree sitter configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Tree sitter configuration
;;

;;; Code:

(use-package tree-sitter
  :hook (after-init . global-tree-sitter-mode)
  :diminish tree-sitter-mode)

(provide 'init-tree-sitter)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-tree-sitter.el ends here
