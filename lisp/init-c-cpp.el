(setq c-cpp-completion-mode-value "cquery")

(setq c-basic-offset 4)

(defun c-cpp-completion-mode/cquery ()
  (require-packages '(lsp-mode
                      lsp-ui
                      cquery))

  (setq cquery-path (concat
                     dotfiles-dir
                     "site-lisp/package/cquery/build/cquery"))

  (use-package cquery
    :commands lsp-cquery-enable
    :init
    (setq cquery-executable cquery-path)
    (setq cquery-cache-dir "/tmp/")
    (add-hook 'c-mode-hook 'lsp-cquery-enable)
    (add-hook 'c++-mode-hook 'lsp-cquery-enable)
    ;; https://github.com/cquery-project/emacs-cquery/issues/45#issuecomment-406813724
    (add-hook 'lsp-after-open-hook 'lsp-ui-mode)))

(cond ((string= c-cpp-completion-mode-value "cquery")
       (funcall 'c-cpp-completion-mode/cquery)))


(defun defined/c-cpp-file-path ()
  (defined/file-path)
  (setq defined/build-path (concat
                            "/tmp/build/"
                            defined/file-name-without-extension-path))
  (setq defined/n-cmakefile (concat
                             defined/build-path
                             "/CMakeLists.txt")))

;; Generate Makefile for single C/CPP file
(defun defined/c-cpp-generate-cmakelists ()
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
