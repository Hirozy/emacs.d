;;; init-exec-path.el --- exec path from shell

;;; Commentary:
;;
;; exec path from shell
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(exec-path-from-shell))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  ;; The shell name is defined by `exec-path-from-shell-shell-name'
  ;; or `shell-file-name' (if set).
  (exec-path-from-shell-copy-envs (list "WORKON_HOME"
                                        "PYTHONPATH"))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)

;;; init-exec-path.el ends here
