;;; init-defun.el --- Defined function by myself -*- lexical-binding: t -*-

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

(provide 'init-defun)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-defun.el ends here
