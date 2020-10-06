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
                    pyvenv
                    poetry))

(use-package ein
  :hook (ein:notebook-multilang-mode . (lambda ()
                                         (company-mode -1))))

;; Use ipython instead of Python
(setq-default python-shell-interpreter "ipython"
              python-shell-interpreter-args "-i --simple-prompt"
              python-shell-completion-native-enable nil)

(provide 'init-python)

;;; init-python.el ends here
