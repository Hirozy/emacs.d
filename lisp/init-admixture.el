;;; init-admixture.el --- Mixed languages -*- lexical-binding: t -*-

;;; Commentary:
;;
;; A mode file that mixes multiple programming languages
;;

;;; Code:

(use-package lua-mode
  :defer t
  :mode "\\.lua\\'")

(use-package fish-mode :defer t)

(use-package dockerfile-mode :defer t)

(use-package cmake-mode :defer t)

(use-package yaml-mode :defer t)

(provide 'init-admixture)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-admixture.el ends here
