;;; init-tabnine.el --- TabNine configuration

;;; Commentary:
;;
;; TabNine configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(company-tabnine))

;; The free version of TabNine is good enough,
;; and below code is recommended that TabNine not always
;; prompt me to purchase a paid version in a large project.
(defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
  (let ((company-message-func (ad-get-arg 0)))
    (when (and company-message-func
               (stringp (funcall company-message-func)))
      (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
        ad-do-it))))

(use-package company-tabnine
  :after company
  :config
  (add-to-list 'company-backends #'company-tabnine))

(provide 'init-tabnine)

;;; init-tabnine.el ends here
