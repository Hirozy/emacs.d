;;; init-treesitter.el --- Enable tree-sitter support -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Enable tree-sitter support
;;

;;; Code:

(dolist (mapping '((python python-mode python-ts-mode)
                   (json js-json-mode json-ts-mode)
                   (c c-mode c-ts-mode)
                   (cpp c++-mode c++-ts-mode)
                   (go go-mode go-ts-mode)
                   (rust rust-mode rust-ts-mode)))
  (pcase-let ((`(,language ,legacy-mode ,treesit-mode) mapping))
    (when (and (fboundp 'treesit-language-available-p)
               (treesit-language-available-p language))
      (setf (alist-get legacy-mode major-mode-remap-alist) treesit-mode))))

(provide 'init-treesitter)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-treesitter.el ends here
