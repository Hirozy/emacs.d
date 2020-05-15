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

(provide 'init-defined)

;;; init-defined.el ends here
