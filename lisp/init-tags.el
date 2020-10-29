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
  :bind (("C-c C-g C-r" . ggtags-find-reference)
         ("C-c C-g C-d" . ggtags-find-definition)
         ("C-c C-g C-c" . ggtags-find-tag-dwim)
         ("C-c C-g C-e" . ggtags-find-tag-regexp)
         ("C-c C-g C-s" . ggtags-find-other-symbol)
         ("C-c C-g C-f" . ggtags-find-file)
         ("C-c C-g C-p" . ggtags-query-replace)
         ("C-c C-g C-h" . ggtags-view-tag-history)
         ("C-c C-g C-c" . ggtags-create-tags)
         ("C-c C-g C-u" . ggtags-update-tags))
  :hook ((c-mode
          c++-mode
          python-mode) . ggtags-mode))

(use-package counsel-gatgs
  :bind (("C-c C-g b" . counsel-gtags-go-backward)
         ("C-c C-g r" . counsel-gtags-go-forward)))

(provide 'init-tags)

;;; init-tags.el ends here
