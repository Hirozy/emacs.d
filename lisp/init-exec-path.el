;;; init-exec-path.el --- exec path from shell  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; exec path from shell
;;

;;; Code:

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  ;; The shell name is defined by `exec-path-from-shell-shell-name'
  ;; or `shell-file-name' (if set).
  (setq exec-path-from-shell-warn-duration-millis 1000)
  (setq exec-path-from-shell-variables '("PATH"
                                         "WORKON_HOME"
                                         "PYTHONPATH"
                                         "GTAGSCONF"
                                         "GTAGSLABEL"
                                         "GTAGSOBJDIRPREFIX"))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-exec-path.el ends here
