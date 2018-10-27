;;; init-end.el --- End function configuration

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
(defcustom package-selected-packages nil
  (customize-save-variable 'package-selected-packages
                           require-package-list))

(provide 'init-end)

;;; init-end.el ends here
