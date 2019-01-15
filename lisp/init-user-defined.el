;;; init-user-defined.el --- Defined function by myself

;;; Commentary:
;;
;; Defined function by myself
;;

;;; Code:

(defun defined/indent-buffer ()
  "Format current buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun defined/smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode.
http://emacsredux.com/blog/2013/06/15/open-line-above/"
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun defined/kill-async-shell ()
  "Kill async shell."
  (when (get-buffer "*Async Shell Command*")
    (kill-buffer "*Async Shell Command*")))

(defun defined/compile-run-file ()
  "Different behavior for modes when run file."
  (interactive)
  (defined/kill-async-shell)
  (cond
   ((derived-mode-p 'python-mode) (defined/python-file-run-in-shell))
   ((derived-mode-p 'c++-mode) (defined/c-cpp-compile-run))
   ((derived-mode-p 'c-mode) (defined/c-cpp-compile-run))
   ((derived-mode-p 'go-mode) (defined/go-file-run-in-shell))))

(global-set-key (kbd "<f10>") 'defined/compile-run-file)

(provide 'init-user-defined)

;;; init-user-defined.el ends here
