;; Save "package-selected-packages" to "custom-set-variables"
;; to custom.el
(delete-dups require-package-list)
(defcustom package-selected-packages nil
  (customize-save-variable 'package-selected-packages
                           require-package-list))

(provide 'init-end)
