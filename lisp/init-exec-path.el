;;; init-exec-path.el --- exec path from shell  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; exec path from shell
;;

;;; Code:

(use-package exec-path-from-shell
  :if (memq window-system '(ns x pgtk))
  :custom
  ;; The shell name is defined by `exec-path-from-shell-shell-name'
  ;; or `shell-file-name' (if set).
  (exec-path-from-shell-warn-duration-millis 1000)
  (exec-path-from-shell-variables '("PATH"
                                    "KUBECONFIG"
                                    "GOPATH"
                                    "GOROOT"
                                    "GO111MODULE"
                                    "WORKON_HOME"
                                    "PYTHONPATH"
                                    "GTAGSCONF"
                                    "GTAGSLABEL"
                                    "GTAGSOBJDIRPREFIX"))
  :config
  (when (eq system-type 'gnu/linux)
    (nconc exec-path-from-shell-variables '("HTTP_PROXY"
                                            "HTTPS_PROXY"
                                            "NO_PROXY")))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-exec-path.el ends here
