;;; init-python.el --- python-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; python-mode configuration
;;

;;; Code:

(setq python-shell-completion-native-enable nil)

(use-package conda
  :defer t)

(provide 'init-python)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-python.el ends here
