;;; init-utils.el --- Utils configuration

;;; Commentary:
;;
;; Utils configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(which-key
                    avy
                    ztree
                    vterm
                    golden-ratio
                    highlight-indent-guides
                    diminish))

(use-package which-key
  :diminish which-key-mode
  :init
  ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
  ;; zero might cause issues so a non-zero value is recommended.
  (setq which-key-idle-delay 0.1)
  :config
  (which-key-mode 1))

(use-package avy)

(use-package winner
  :hook (after-init . winner-mode))

(use-package vterm)

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config
  (golden-ratio-mode 1))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))

(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'abbrev-mode))

(use-package open-newline
  :load-path "site-lisp/open-newline")

(provide 'init-utils)

;;; init-utils.el ends here
