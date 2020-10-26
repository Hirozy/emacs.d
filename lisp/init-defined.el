;;; init-defined.el --- Defined function by myself

;;; Commentary:
;;
;; Defined function by myself
;;

;;; Code:

(defun defined/smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode.
http://emacsredux.com/blog/2013/06/15/open-line-above/"
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun defined/derived-from-prog-mode ()
  "Detect if the current major mode is derived from `prog-mode'."
  (interactive)
  (if (derived-mode-p 'prog-mode)
      (message "True")
    (message "False")))

(defun defined/derived-from-text-mode ()
  "Detact if the current major mode is derived from `text-mode'."
  (interactive)
  (if (derived-mode-p 'text-mode)
      (message "True")
    (message "False")))

(provide 'init-defined)

;;; init-defined.el ends here
