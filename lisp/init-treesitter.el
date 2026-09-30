;;; init-treesitter.el --- Enable tree-sitter support -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Enable tree-sitter support
;;

;;; Code:

(require 'treesit)

(setopt treesit-enabled-modes
        '(python-ts-mode json-ts-mode c-ts-mode c++-ts-mode
          go-ts-mode rust-ts-mode))

(provide 'init-treesitter)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-treesitter.el ends here
