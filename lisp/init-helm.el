;;; init-helm.el --- helm configuration

;;; Commentary:
;;
;; helm configuration
;; Emacs incremental completion and selection narrowing framework
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(helm
                    helm-swoop
                    helm-descbinds))

(use-package helm
  :init
  (setq helm-autoresize-max-height 60
        helm-autoresize-min-height 10
        ;; To globally enable fuzzy matching for helm-mode
        helm-mode-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        ;; Set matching limit
        helm-candidate-number-limit 50)
  :bind
  ;; ("M-x" . helm-M-x)
  ;; ("C-x C-f" . helm-find-files)
  ;; ([f10] . helm-buffers-list)
  :config
  (helm-autoresize-mode 1)
  (helm-mode nil))

(use-package helm-config)

(use-package helm-swoop
  :init
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t
        ;; If this value is t, split window inside the current window
        helm-swoop-split-with-multiple-windows nil
        ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
        helm-swoop-split-direction 'split-window-horizontally
        ;; If nil, you can slightly boost invoke speed in exchange for text color, highlight
        helm-swoop-speed-or-color t
        ;; Go to the opposite side of line from the end or beginning of line
        helm-swoop-move-to-line-cycle nil
        ;; Optional face for line numbers
        ;; Face name is `helm-swoop-line-number-face`
        helm-swoop-use-line-number-face t
        ;; If you prefer fuzzy matching
        helm-swoop-use-fuzzy-match nil)
  :config
  ;; If you would like to use migemo, enable helm's migemo feature
  ;; (helm-migemo-mode 1)
  )

;; backspace to quit helm
(defun helm-backspace ()
  "Forward to `backward-delete-char'.
On error (read-only), quit without selecting."
  (interactive)
  (condition-case nil
      (backward-delete-char 1)
    (error
     (helm-keyboard-quit))))
(define-key helm-map (kbd "DEL") 'helm-backspace)

(use-package helm-descbinds
  :config
  (helm-descbinds-mode 1))

(provide 'init-helm)

;;; init-helm.el ends here
