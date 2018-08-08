;; Efficiently hopping squeezed lines powered by Emacs helm interface
(require 'helm)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-horizontally)

;; If nil, you can slightly boost invoke speed in exchange for text color, highlight
(setq helm-swoop-speed-or-color t)

;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle nil)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match nil)

;; If you would like to use migemo, enable helm's migemo feature
;; (helm-migemo-mode 1)

(provide 'init-helm-swoop)
