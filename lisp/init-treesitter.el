;;; init-treesitter.el --- Enable tree-sitter support -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Enable tree-sitter suppoet
;;

;;; Code:

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (js-json-mode . json-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (go-mode . go-ts-mode)
        (rust-mode . rust-ts-mode)))

(provide 'init-treesitter)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-treesitter.el ends here
