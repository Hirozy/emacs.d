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
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "PYTHONPATH")))

(provide 'init-exec-path)

;;; init-exec-path.el ends here
