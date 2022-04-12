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
                    poetry
                    conda))

(setq python-shell-completion-native-enable nil)

(use-package ein
  :hook (ein:notebook-multilang-mode . (lambda ()
                                         (company-mode -1))))

(use-package conda)

(provide 'init-python)

;;; init-python.el ends here
