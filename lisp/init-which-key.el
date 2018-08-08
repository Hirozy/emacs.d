;; Emacs package that displays available keybindings in popup
;; which-key

(require 'which-key)
(which-key-mode)

;; Set the time delay (in seconds) for the which-key popup to appear. A value of
;; zero might cause issues so a non-zero value is recommended.
(setq which-key-idle-delay 0.1)

(provide 'init-which-key)