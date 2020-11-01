;;; init-defined.el --- Defined function by myself

;;; Commentary:
;;
;; Defined function by myself
;;

;;; Code:

(defun defined/derived-mode-prog-or-text-mode ()
  "Detect if the current major mode is derived from `prog-mode' or `text-mode'."
  (interactive)
  (cond ((derived-mode-p 'prog-mode)
         (message "Major mode is prog-mode."))
        ((derived-mode-p 'text-mode)
         (message "Major mode is text-mode."))
        (t
         (message "Major mode is neither prog-mode or text-mode."))))

(defun defined/get-buffer-file-name ()
  "Echo current buffer file full path."
  (interactive)
  (message buffer-file-name))

(provide 'init-defined)

;;; init-defined.el ends here
