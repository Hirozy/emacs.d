;;; init-c-cpp.el --- c-mode/c++-mode configuratione

;;; Commentary:
;;
;; c-mode/c++-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'init-user-defined)

;;; Code:

(setq-default c-basic-offset 4)

(setq compilation-finish-functions 'defined/compile-finished)
(defvar defined/build-successful-flag nil)
(defvar defined/current-buffer-file-name)

(defun defined/compile-finished (buffer string)
  "Determine whether it is completed, BUFFER STRING."
  (if (string-match "finished" string)
      (async-shell-command (concat
                            "/tmp/build/"
                            (file-name-base defined/current-buffer-file-name)
                            ".out"))))

(defvar defined/gcc-g++-args)
(add-hook 'c++-mode-hook
          (lambda ()
            (setq defined/gcc-g++-args "g++ -O2 -Wall -g -ggdb -std=c++14")))

(add-hook 'c-mode-hook
          (lambda ()
            (setq defined/gcc-g++-args "gcc -O2 -g -std=c11")))

(defun defined/c-cpp-compile-run ()
  "C/C++ run directly."
  (interactive)
  (unless (file-exists-p "/tmp/build")
    (shell-command "mkdir -p /tmp/build"))
  (save-buffer)
  (defined/kill-async-shell)
  (setq defined/current-buffer-file-name (buffer-file-name))
  (compile (concat
            defined/gcc-g++-args
            " "
            defined/current-buffer-file-name
            " -o /tmp/build/"
            (file-name-base defined/current-buffer-file-name)
            ".out")))

(provide 'init-c-cpp)

;;; init-c-cpp.el ends here
