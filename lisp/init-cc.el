;;; init-cc.el --- c-mode/c++-mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; c-mode/c++-mode configuration
;;

;;; Code:

(setq-default c-basic-offset 4)

(defun defined/cc-mode-setup ()
  "Configure shared C and C++ key bindings."
  (local-set-key (kbd "C-c o") #'ff-find-other-file))

(dolist (hook '(c-mode-common-hook c-ts-mode-hook c++-ts-mode-hook))
  (add-hook hook #'defined/cc-mode-setup))

(provide 'init-cc)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-cc.el ends here
