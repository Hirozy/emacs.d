;;; init-c-cpp.el --- c-mode/c++-mode configuratione

;;; Commentary:
;;
;; c-mode/c++-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'init-user-defined)

;;; Code:

(require-packages '(company-c-headers))

(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (setq company-c-headers-path-system '("/usr/include/"
                                        "/usr/local/include/"))
  (when (equal system-type 'darwin)
    (setq company-c-headers-path-system
          (append company-c-headers-path-system '("/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1/"
                                                  "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/"
                                                  "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/10.0.0/include/"
                                                  "/Library/Developer/CommandLineTools/usr/include/c++/v1/"
                                                  "/Library/Developer/CommandLineTools/usr/include/"
                                                  "/Library/Developer/CommandLineTools/usr/lib/clang/10.0.0/include/")))))

(setq compilation-finish-functions 'defined/compile-finished)
(defvar defined/build-successful-flag nil)
(defvar defined/current-buffer-file-name)

(defun defined/compile-finished (buffer string)
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

(shell-command "mkdir -p /tmp/build")

(defun defined/c-cpp-compile-run ()
  "C/C++ run directly."
  (interactive)
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
