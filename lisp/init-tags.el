;;; init-tags.el --- Tags configuration

;;; Commentary:
;;
;; Tags configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(ggtags
                    counsel-gtags))

(use-package ggtags
  :bind (("C-c C-g s" . ggtags-find-other-symbol)
         ("C-c C-g h" . ggtags-view-tag-history)
         ("C-c C-g f" . ggtags-find-reference)
         ("C-c C-g c" . ggtags-create-tags)
         ("C-c C-g u" . ggtags-update-tags))
  :hook ((c-mode . ggtags-mode)
         (c++-mode . ggtags-mode)
         (python-mode . ggtags-mode)))

(use-package counsel-gatgs
  :bind (("C-c C-g b" . counsel-gtags-go-backward)
         ("C-c C-g r" . counsel-gtags-go-forward)))

(provide 'init-tags)

;;; init-tags.el ends here
