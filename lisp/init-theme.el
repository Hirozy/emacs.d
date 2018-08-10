(require-packages '(color-theme-solarized))

(use-package color-theme-solarized
    :init
    ;; Set background to dark for color-theme-solarized
    (set-frame-parameter nil 'background-mode 'dark)
    (set-terminal-parameter nil 'background-mode 'dark))

(load-theme 'solarized t)

(provide 'init-theme)
