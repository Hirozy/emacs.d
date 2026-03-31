;;; init-defun.el --- Defined function by myself  -*- lexical-binding: t; -*-

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

(defun defined/get-buffer-file-path ()
  "Echo current buffer file full path."
  (interactive)
  (message buffer-file-name))

(defun defined/toggle-cape-dict-local ()
  "Toggle `cape-dict' completion in the current buffer.

If `cape-dict' is currently active in `completion-at-point-functions'
for this buffer, it will be removed. Otherwise, it will be added."
  (interactive)
  (if (memq #'cape-dict completion-at-point-functions)
      (progn
        (remove-hook 'completion-at-point-functions #'cape-dict t)
        (message "Disable `cape-dict' completion in this buffer"))
    (add-hook 'completion-at-point-functions #'cape-dict)
    (message "Enable `cape-dict' completion in this buffer")))

(provide 'init-defun)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-defun.el ends here
