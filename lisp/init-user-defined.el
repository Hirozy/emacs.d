;; Format the current buffer
(defun defined/indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

;; Reload Emacs config
(defun defined/reload-init-file ()
  (interactive)
  (load-file (concat dotfiles-dir "init.el")))

;; http://emacsredux.com/blog/2013/06/15/open-line-above/
(defun defined/smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(provide 'init-user-defined)
