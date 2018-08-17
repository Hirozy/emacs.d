(setq c-cpp-completion-mode-value "cquery")

(setq c-basic-offset 4)

(defun c-cpp-completion-mode/cquery ()
  (require-packages '(lsp-mode
                      lsp-ui
                      cquery))

  (setq cquery-path (concat dotfiles-dir "site-lisp/package/cquery/build/cquery"))

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
  (setq file-name-with-path (buffer-file-name))
  (setq file-name-without-path (file-name-nondirectory
                                file-name-with-path))
  (setq file-name-without-extension (file-name-sans-extension
                                     file-name-without-path))
  (setq file-path-without-file-name (file-name-directory
                                     file-name-with-path))
  (setq defined/build-path (concat
                            "/tmp/build/"
                            file-name-without-extension))
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
                     file-name-without-extension)
             (format "\n\nSET(CMAKE_CXX_FLAGS \"%s\")"
                     c-cpp-generate-compiler)
             (format "\n\nadd_executable(%s %s)"
                     file-name-without-extension
                     file-name-with-path)
             (format "\n\nadd_custom_target(run\n\tCOMMAND ${CMAKE_CURRENT_BINARY_DIR}/%s\n)"
                     file-name-without-extension)))
    (save-buffer))
  (let ((default-directory defined/build-path))
    (shell-command "cmake .")))

(defun defined/cpp-run ()
  (interactive)
  (save-buffer)
  (defined/c-cpp-file-path)
  (let ((default-directory defined/build-path))
    (shell-command "make")
    (shell-command "make run")))

(defun defined/c-run ()
  (interactive)
  (defined/cpp-run))

(add-hook 'c++-mode-hook
          (lambda()
            (define-key c++-mode-map [f5] 'defined/cpp-run)
            (defvar c-cpp-generate-compiler "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb -std=c++14")))
(add-hook 'c-mode-hook
          (lambda()
            (define-key c-mode-map [f5] 'defined/c-run)
            (defvar c-cpp-generate-compiler "$ENV{CFLAGS} -O2 -g -std=c99")))

(setq compilation-ask-about-save nil)
(setq compilation-finish-functions
      (list (lambda(buffer str)
              (unless (string= str "Finished\n")
                (push-mark)
                (next-error)))))

(provide 'init-c-cpp)
