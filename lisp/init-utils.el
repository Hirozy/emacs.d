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
                    ztree))

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

(provide 'init-utils)

;;; init-utils.el ends here
