(require-packages '(which-key))

(use-package which-key
    :init
    ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
    ;; zero might cause issues so a non-zero value is recommended.
    (setq which-key-idle-delay 0.1)
    :config
    (which-key-mode 1))

(provide 'init-which-key)
