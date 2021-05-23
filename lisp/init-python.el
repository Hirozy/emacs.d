;;; init-python.el --- python-mode configuration

;;; Commentary:
;;
;; python-mode configuration
;;

;;; Require
(require 'init-packages)
(require 'python)

;;; Code:

(require-packages '(ein
                    pyvenv
                    poetry))

(setq python-shell-completion-native-enable nil)

(use-package ein
  :hook (ein:notebook-multilang-mode . (lambda ()
                                         (company-mode -1))))

(provide 'init-python)

;;; init-python.el ends here
