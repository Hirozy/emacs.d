;;; init-mark.el --- markdown mode configuration

;;; Commentary:
;;
;; markdown mode configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(markdown-mode))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown"))

(provide 'init-markdown)

;;; init-markdown.el ends here
