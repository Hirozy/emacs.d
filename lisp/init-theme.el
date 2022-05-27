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

(use-package doom-themes
  :defines (doom-themes-treemacs-theme)
  :if (memq window-system '(mac ns x))
  :after treemacs
  :config
  (setq doom-themes-treemacs-theme "doom-colors")

  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(provide 'init-theme)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-theme.el ends here
