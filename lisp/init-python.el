;;; init-python.el --- python-mode configuration

;;; Commentary:
;;
;; python-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'init-completion)
(require 'init-user-defined)

;;; Code:

(require-packages '(ein
                    pyvenv))

(defvar python-completion-mode-value "anaconda")

;; Use ipython instead of Python
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt"
      python-shell-completion-native-enable nil)

(defun python-completion-mode/anaconda ()
  "Completion Python with anaconda-mode."
  (require-packages '(anaconda-mode
                      company-anaconda))

  (use-package anaconda-mode
    :init
    ;; Enable anaconda-mode hook
    (add-hook 'python-mode-hook 'anaconda-mode))

  (use-package company-anaconda
    :init
    ;; Change backgends to company-anaconda
    (eval-after-load "company"
      '(add-to-list 'company-backends 'company-anaconda))))

(defun python-completion-mode/elpy ()
  "Completion Python with elpy."
  (require-packages '(elpy))

  (use-package elpy
    :init
    (elpy-enable 1)))

(defun python-completion-mode/lsp ()
  "Completion Python with lsp-mode (Language Server Protocol for Python)."
  (require-packages '(lsp-mode))

  (use-package lsp-mode
    :config
    (add-hook 'python-mode-hook
              (lambda ()
                (lsp-python-enable)))
    (lsp-define-stdio-client lsp-python "python"
                             (lsp-make-traverser #'(lambda (dir)
                                                     (directory-files
                                                      dir
                                                      nil
                                                      "\\(__init__\\|setup\\)\\.py\\|Pipfile")))
                             '("pyls")))

  (use-package lsp-ui
    :init
    (add-hook 'python-mode-hook 'flycheck-mode)))

(defun defined/python-file-run-in-shell ()
  "Run python file in async shell."
  (interactive)
  (save-buffer)
  (defined/file-path)
  (defined/kill-async-shell)
  (async-shell-command
   (format "python %s"
           defined/file-name-with-path)))

(defun defined/python-file-run ()
  "Run python file in python shell."
  (interactive)
  (save-buffer)
  (python-shell-send-file buffer-file-name))

(cond ((string= python-completion-mode-value "anaconda")
       (funcall 'python-completion-mode/anaconda))
      ((string= python-completion-mode-value "elpy")
       (funcall 'python-completion-mode/elpy))
      ((string= python-completion-mode-value "lsp")
       (funcall 'python-completion-mode/lsp)))

(provide 'init-python)

;;; init-python.el ends here
