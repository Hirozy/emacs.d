;;; init-mark.el --- markdown mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; markdown mode configuration
;;

;;; Code:

(use-package markdown-mode
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown"))

(provide 'init-markdown)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-markdown.el ends here
