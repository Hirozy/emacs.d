;;; init-elpa.el --- elpa configuration

;;; Commentary:
;;
;; elpa configuration
;;

;;; Require
(require 'package)

;;; Code:

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(provide 'init-elpa)

;;; init-elpa.el ends here
