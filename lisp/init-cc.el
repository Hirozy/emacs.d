;;; init-cc.el --- c-mode/c++-mode configuratione  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; c-mode/c++-mode configuration
;;

;;; Code:

(setq-default c-basic-offset 4)

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

(provide 'init-cc)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-cc.el ends here
