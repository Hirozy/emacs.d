;;; init-langs.el --- Various languages  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; A mode file that mixes multiple programming languages
;;

;;; Code:

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package fish-mode :defer t)

(use-package dockerfile-mode :defer t)

(use-package cmake-mode :defer t)

(use-package yaml-mode :defer t)

(provide 'init-langs)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-langs.el ends here
