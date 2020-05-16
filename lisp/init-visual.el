;;; init-visual.el --- visual configuration

;;; Commentary:
;;
;; visual configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(golden-ratio
                    highlight-indentation
                    diminish
                    fill-column-indicator))

(use-package golden-ratio
  :diminish golden-ratio-mode
  ;; :init
  ;; https://github.com/emacs-helm/helm/issues/238#issuecomment-16490626
  ;; (setq golden-ratio-exclude-buffer-names '("*helm M-x*" "*helm for files*"))
  ;; (setq golden-ratio-auto-scale t)
  :config
  (golden-ratio-mode 1))

(use-package highlight-indentation
  :diminish highlight-indentation-mode
  :hook (prog-mode . highlight-indentation-mode))

;; (USE-package highlight-indent-guides
;; highlight-indent-guides conflict with ein
;;   :diminish highlight-indent-guides-mode
;;   ;; :hook ((prog-mode . highlight-indent-guides-mode))
;;   :config
;;   (setq highlight-indent-guides-method 'character
;;         ;; https://github.com/DarthFennec/highlight-indent-guides/issues/32#issuecomment-376587172
;;         highlight-indent-guides-auto-enabled nil))

(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'abbrev-mode))

;; (define-globalized-minor-mode
;;   global-fci-mode fci-mode
;;   (lambda ()
;;     (fci-mode 1)))

;; (use-package fill-column-indicator
;;   :init
;;   (setq fci-rule-width 1)
;;   (setq fci-rule-color "dimgray")
;;   (setq fci-rule-column 80)
;;   :config
;;   (global-fci-mode 1))

(provide 'init-visual)

;;; init-visual.el ends here
