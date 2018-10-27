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

(defvar c-cpp-completion-mode-value "cquery")

(set-default c-basic-offset 4)

(defun c-cpp-completion-mode/cquery ()
  "C/C++ completion with cquery."
  (require-packages '(cquery))
  (require 'init-lsp)

  (use-package cquery
    :commands lsp-cquery-enable
    :init
    (setq cquery-executable "cquery"
          cquery-cache-dir "/tmp/")
    :hook
    (c-mode . lsp-cquery-enable)
    (c++-mode . lsp-cquery-enable)))

(cond ((string= c-cpp-completion-mode-value "cquery")
       (funcall 'c-cpp-completion-mode/cquery)))

(defun defined/c-cpp-file-path ()
  "Get C/C++ file's build path and Cmakefile path."
  (defined/file-path)
  (setq defined/build-path (concat
                            "/tmp/build/"
                            defined/file-name-without-extension-path))
  (setq defined/n-cmakefile (concat
                             defined/build-path
                             "/CMakeLists.txt")))

(defun defined/c-cpp-generate-cmakelists ()
  "Generate Makefile for single C/CPP file."
  (interactive)
  (defined/c-cpp-file-path)
  (unless (file-exists-p defined/build-path)
    (make-directory defined/build-path
                    'parents))
  (with-current-buffer (find-file-noselect defined/n-cmakefile)
    (erase-buffer)
    (insert
     (concat "cmake_minimum_required (VERSION 3.10)"
             (format "\n\nproject(%s)"
                     defined/file-name-without-extension-path)
             (format "\n\nSET(CMAKE_CXX_FLAGS \"%s\")"
                     c-cpp-cmake-compiler)
             (format "\n\nadd_executable(%s %s)"
                     defined/file-name-without-extension-path
                     defined/file-name-with-path)
             (format "\n\nadd_custom_target(run\n\tCOMMAND ${CMAKE_CURRENT_BINARY_DIR}/%s\n)"
                     defined/file-name-without-extension-path)))
    (save-buffer))
  (let ((default-directory defined/build-path))
    (shell-command "cmake .")))

(setq compilation-finish-functions 'defined/compile-finished)
(defun defined/compile-finished (buffer string)
  (cond ((string-match "finished" string)
         (setq defined/build-successful-flag t)
         (message "Build maybe successful: start run."))
        (t
         (setq defined/build-successful-flag nil)
         (message "Compilation exited abnormally: %s" string))))

(defun defined/c-cpp-cmake-run ()
  "C/C++ run through cmake."
  (interactive)
  (save-buffer)
  (defined/c-cpp-file-path)
  (defined/kill-async-shell)
  (setq defined/build-successful-flag nil)
  (let ((default-directory defined/build-path))
    (compile "make")
    (run-with-timer 3 nil
                    (lambda()
                      (if defined/build-successful-flag
                          (let ((default-directory defined/build-path))
                            (async-shell-command "make run &")))))))

(defun defined/c-cpp-compile-run ()
  "C/C++ run directly."
  (interactive)
  (save-buffer)
  (defined/c-cpp-file-path)
  (defined/kill-async-shell)
  (compile (concat
            c-cpp-generate-compiler
            " "
            defined/file-name-with-path
            " -o /tmp/"
            defined/file-name-without-extension-path
            ".out"))
  (run-with-timer 3 nil
                  (lambda()
                    (if defined/build-successful-flag
                        (async-shell-command (concat
                                              "/tmp/"
                                              defined/file-name-without-extension-path
                                              ".out"))))))

(add-hook 'c++-mode-hook
          (lambda()
            (setq defined/g++-args "-O2 -Wall -g -ggdb -std=c++14")
            (setq c-cpp-generate-compiler (concat
                                           "g++ "
                                           defined/g++-args))
            (setq c-cpp-cmake-compiler (concat
                                        "$ENV{CXXFLAGS} "
                                        defined/g++-args))))

(add-hook 'c-mode-hook
          (lambda()
            (setq defined/g++-args "-O2 -g -std=c11")
            (setq c-cpp-generate-compiler (concat
                                           "gcc "
                                           defined/g++-args))
            (setq c-cpp-cmake-compiler (concat
                                        "$ENV{CFLAGS} "
                                        defined/g++-args))))

(provide 'init-c-cpp)

;;; init-c-cpp.el ends here
