;;; init-plot.el --- plot configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; plot configuration
;;

;;; Code:

(use-package gnuplot
  :defer t
  :mode (("\\.gp\\'" . gnuplot-mode)
         ("\\.plt\\'" . gnuplot-mode)))

(use-package plantuml-mode
  :defer t
  :custom
  (plantuml-default-exec-mode 'executable)
  :mode (("\\.puml\\'" . plantuml-mode)
         ("\\.plantuml\\'" . plantuml-mode)))

(provide 'init-plot)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-plot.el ends here
