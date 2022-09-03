;;; init-python.el --- python-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; python-mode configuration
;;

;;; Code:

(defun defined/set-current-path-to-pythonpath (prompt)
  "Add current path to PYTHONPATH, if PROMPT is non-nil, reset current path to PYTHONPATH."
  (interactive "P")
  (let ((current-path (expand-file-name default-directory)))
    (if current-prefix-arg
        (progn
          (message "Reset %S to PYTHONPATH" current-path)
          (setenv "PYTHONPATH" current-path))
      (progn
        (message "Add %S to PYTHONPATH" current-path)
        (setenv "PYTHONPATH" (concat current-path ":" (getenv "PYTHONPATH")))))))

(setq python-shell-completion-native-enable nil)

(use-package conda
  :defer t)

(provide 'init-python)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-python.el ends here
