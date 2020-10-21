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

(use-package gnuplot
  :mode (("\\.gp\\'" . gnuplot-mode)
         ("\\.plt\\'" . gnuplot-mode)))

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4)

  (use-package company-graphviz-dot))

(provide 'init-plot)

;;; init-plot.el ends here
