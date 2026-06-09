;;; init-python.el --- python-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; python-mode configuration
;;

;;; Code:

(defun defined/set-current-path-to-python-path (prompt)
  "Add current path to PYTHONPATH.
If PROMPT is non-nil, reset PYTHONPATH to the current path only."
  (interactive "P")
  (let ((current-path (expand-file-name default-directory)))
    (if prompt
        (progn
          (message "Reset %S to PYTHONPATH" current-path)
          (setenv "PYTHONPATH" current-path))
      (message "Add %S to PYTHONPATH" current-path)
      (setenv "PYTHONPATH" (concat current-path ":" (getenv "PYTHONPATH"))))))

(setq python-shell-completion-native-enable nil)

(provide 'init-python)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-python.el ends here
