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

(defalias 'defined/cape-dict-min (cape-capf-prefix-length #'cape-dict 4))

(defun defined/toggle-cape-dict-local ()
  "Toggle `cape-dict' completion in the current buffer.

If `cape-dict' is currently active in `completion-at-point-functions'
for this buffer, it will be removed. Otherwise, it will be added."
  (interactive)
  (if (memq #'defined/cape-dict-min completion-at-point-functions)
      (progn
        (remove-hook 'completion-at-point-functions #'defined/cape-dict-min t)
        (message "Disable `cape-dict' completion in this buffer"))
    (add-hook 'completion-at-point-functions #'defined/cape-dict-min nil t)
    (message "Enable `cape-dict' completion in this buffer")))

(defun defined/guess-which-org-publish-project ()
  "Display and return the org-publish project name for the current Org file.
Returns the project name if found, nil otherwise."
  (interactive)
  (let ((filename (buffer-file-name)))
    (cond
     ((not filename)
      (message "Buffer is not visiting a file.")
      nil)

     ((not (string-match-p "\\.org\\'" filename))
      (message "This function only works with Org files.")
      nil)

     (t
      (let ((project (org-publish-get-project-from-filename filename)))
        (if project
            (let ((project-name (car project)))
              (message "Current Org file belongs to project: \"%s\"" project-name)
              project-name)
          (message "Current Org file does not belong to any org-publish project.")
          nil))))))


(provide 'init-defun)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-defun.el ends here
