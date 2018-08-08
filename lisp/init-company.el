(require 'company)

(add-hook 'after-init-hook 'global-company-mode)

;; Map "TAB" key to complete code
(global-set-key (kbd "TAB") 'company-complete-selection)

;; (setq tab-always-indent 'complete)

(setq company-minimum-prefix-length 0)
(setq company-idle-delay 0)

(provide 'init-company)