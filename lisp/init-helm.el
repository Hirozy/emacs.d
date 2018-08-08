;; Emacs incremental completion and selection narrowing framework 

(require 'helm)
(require 'helm-config)

;; Bind "M-x" to command help-M-x
(global-set-key (kbd "M-x") 'helm-M-x)

;; Bind "C-x C-f" to command helm-find-files
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; To re-size the completion window based on number of candidates
;; Numbers represents percentage
(setq helm-autoresize-max-height 60)
(setq helm-autoresize-min-height 10)
(helm-autoresize-mode 1)

;; To globally enable fuzzy matching for helm-mode
(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

;; Set matching limit
(setq helm-candidate-number-limit 50)

(helm-mode 1)

(provide 'init-helm)