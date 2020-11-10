;;; init-evil.el --- evil-mode configuration

;;; Commentary:
;;
;; evil-mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(evil
                    evil-anzu
                    evil-escape
                    evil-matchit))

(use-package evil
  :bind ("C-\\" . evil-mode)
  :config
  (use-package evil-escape
    :hook (evil-mode . evil-escape-mode)
    :config
    (setq-default evil-escape-key-sequence "jk"
                  evil-escape-delay 0.2))
  (use-package evil-matchit)
  (use-package evil-anzu))

(provide 'init-evil)

;;; init-evil.el ends here
