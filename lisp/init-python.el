;;; init-python.el --- python-mode configuration

;;; Commentary:
;;
;; python-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'init-completion)

;;; Code:

(require-packages '(ein
                    pyvenv))

(use-package ein
  :hook (ein:notebook-multilang-mode . (lambda ()
                                         (company-mode -1))))

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
    :config
    (elpy-enable)))

(cond ((string= python-completion-mode-value "anaconda")
       (funcall 'python-completion-mode/anaconda))
      ((string= python-completion-mode-value "elpy")
       (funcall 'python-completion-mode/elpy)))

(provide 'init-python)

;;; init-python.el ends here
