;;; init-postconfig.el --- End function configuration

;;; Commentary:
;;
;; End function configuration
;; Save "package-selected-packages" to "custom-set-variables"
;; to custom.el
;;

;;; Require
(require 'init-packages)

;;; Code:

(delete-dups require-package-list)
(setq package-selected-packages require-package-list)

(provide 'init-postconfig)

;;; init-postconfig.el ends here
