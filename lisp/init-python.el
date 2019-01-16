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
(setq-default python-shell-interpreter "ipython"
              python-shell-interpreter-args "-i --simple-prompt"
              python-shell-completion-native-enable nil)

(defun python-completion-mode/anaconda ()
  "Completion Python with anaconda-mode."
  (require-packages '(anaconda-mode
                      company-anaconda))

  (use-package anaconda-mode
    :hook (python-mode . anaconda-mode))

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
    :hook (python-mode . (lambda ()
                           (lsp-python-enable)))
    :config
    (lsp-define-stdio-client lsp-python "python"
                             (lsp-make-traverser #'(lambda (dir)
                                                     (directory-files
                                                      dir
                                                      nil
                                                      "\\(__init__\\|setup\\)\\.py\\|Pipfile")))
                             '("pyls")))

  (use-package lsp-ui
    :hook (python-mode . flycheck-mode)))

(defun defined/python-file-run-in-shell ()
  "Run Python file in async shell."
  (interactive)
  (save-buffer)
  (defined/kill-async-shell)
  (async-shell-command
   (format "python %s" buffer-file-name)))

(cond ((string= python-completion-mode-value "anaconda")
       (funcall 'python-completion-mode/anaconda))
      ((string= python-completion-mode-value "elpy")
       (funcall 'python-completion-mode/elpy))
      ((string= python-completion-mode-value "lsp")
       (funcall 'python-completion-mode/lsp)))

(provide 'init-python)

;;; init-python.el ends here
