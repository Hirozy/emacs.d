;;; init-elpa.el --- elpa configuration

;;; Commentary:
;;
;; elpa configuration
;;

;;; Require
(require 'package)

;;; Code:

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(provide 'init-elpa)

;;; init-elpa.el ends here
