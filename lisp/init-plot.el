;;; init-plot.el --- plot configuration

;;; Commentary:
;;
;; plot configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(gnuplot
                    graphviz-dot-mode))

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4))

(provide 'init-plot)

;;; init-plot.el ends here
