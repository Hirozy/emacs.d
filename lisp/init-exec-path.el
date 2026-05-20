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
                                    "HTTP_PROXY"
                                    "HTTPS_PROXY"
                                    "NO_PROXY"
                                    "http_proxy"
                                    "https_proxy"
                                    "no_proxy"
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
  (exec-path-from-shell-initialize)
  ;; Sync case-insensitive proxy environment variables
  (dolist (var '("http_proxy" "https_proxy" "no_proxy"))
    (let ((upper (upcase var))
          (lower var))
      (let ((lower-val (getenv lower))
            (upper-val (getenv upper)))
        (cond
         ((and lower-val (not upper-val))
          (setenv upper lower-val))
         ((and upper-val (not lower-val))
          (setenv lower upper-val)))))))

(provide 'init-exec-path)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-exec-path.el ends here
