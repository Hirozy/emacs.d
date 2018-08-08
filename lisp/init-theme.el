(require 'color-theme-solarized)

;; Set background to dark for color-theme-solarized
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
;; https://github.com/sellout/emacs-color-theme-solarized/issues/175#issuecomment-176421965
;; (customize-set-variable 'solarized-termcolors 256)

(load-theme 'solarized t)

(provide 'init-theme)