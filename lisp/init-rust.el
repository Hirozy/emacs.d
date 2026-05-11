;;; init-rust.el --- rust-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; rust-mode configuration
;;

;;; Code:

(use-package rust-mode
  :defer t
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rust-playground
  :commands rust-playground
  :custom
  (rust-playground-basedir (substitute-in-file-name "$HOME/.cache/rust-playground")))

(provide 'init-rust)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-rust.el ends here
