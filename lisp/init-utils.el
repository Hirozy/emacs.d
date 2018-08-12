(require-packages '(which-key
                    avy
                    undo-tree
                    magit))

(use-package which-key
    :init
    ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
    ;; zero might cause issues so a non-zero value is recommended.
    (setq which-key-idle-delay 0.1)
    :config
    (which-key-mode 1))

(use-package avy
    :bind (("M-;" . avy-goto-char)
           ("M-'" . avy-goto-char-2)))

(use-package undo-tree
    :config
    (global-undo-tree-mode 1))

(provide 'init-utils)