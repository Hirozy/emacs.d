;;; init-tags.el --- Tags configuration

;;; Commentary:
;;
;; Tags configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(ggtags
                    counsel-gtags
                    xref
                    ivy-xref))

(use-package ggtags
  :bind (("C-c g r" . ggtags-find-reference)
         ("C-c g d" . ggtags-find-definition)
         ("C-c g c" . ggtags-find-tag-dwim)
         ("C-c g e" . ggtags-find-tag-regexp)
         ("C-c g s" . ggtags-find-other-symbol)
         ("C-c g f" . ggtags-find-file)
         ("C-c g p" . ggtags-query-replace)
         ("C-c g h" . ggtags-view-tag-history)
         ("C-c g c" . ggtags-create-tags)
         ("C-c g u" . ggtags-update-tags))
  :hook ((c-mode
          c++-mode
          python-mode) . ggtags-mode))

(use-package counsel-gatgs
  :bind (("C-c g b" . counsel-gtags-go-backward)
         ("C-c g r" . counsel-gtags-go-forward)))

(use-package xref
  :bind (("<f12>" . xref-find-definitions)
         ("S-<f12>" . xref-find-references))

  :config
  (use-package ivy-xref
    :after ivy
    :init
    (setq xref-show-definitions-function #'ivy-xref-show-defs
          xref-show-xrefs-function #'ivy-xref-show-xrefs)))

(use-package semantic
  :config
  (setq semantic-default-submodes
        '(global-semantic-idle-scheduler-mode
          global-sementic-minor-mode))
  (semantic-mode 1))

(provide 'init-tags)

;;; init-tags.el ends here
