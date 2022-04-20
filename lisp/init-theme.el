;;; init-theme.el --- Theme configuration

;;; Commentary:
;;
;; Theme configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(solarized-theme
                    spacemacs-theme
                    nord-theme
                    doom-themes
                    vscode-dark-plus-theme
                    zenburn-theme))

(load-theme 'vscode-dark t)

(use-package doom-themes
  :defines (doom-themes-treemacs-theme)
  :if (memq window-system '(mac ns x))
  :after treemacs
  :config
  (setq doom-themes-treemacs-theme "doom-colors")

  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(provide 'init-theme)

;;; init-theme.el ends here
