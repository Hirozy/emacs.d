;;; init-theme.el --- Theme configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Theme configuration
;;

;;; Code:

(use-package color-theme-sanityinc-tomorrow
  :custom-face
  (cursor ((t (:background "#afafaf"))))
  :config
  (load-theme 'sanityinc-tomorrow-eighties))

(provide 'init-theme)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-theme.el ends here
