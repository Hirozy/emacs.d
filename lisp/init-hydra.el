;;; init-hydra.el --- hydra configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; hydra configuration
;;

;;; Code:

(defhydra hydra-org-mode (:foreign-keys nil :exit t)
  ("s" org-insert-structure-template "org template" :column "Edit")
  ("h" org-html-export-to-html "export to html")
  ("t" org-table-create "create table")
  ("i" org-indent-mode "indent mode")
  ("RET" org-meta-return "meta return")
  ("'" org-insert-subheading "insert subheading")
  ("<" org-metaleft "meta left" :column "Meta" :exit nil)
  (">" org-metaright "meta right" :exit nil)
  ("l" org-metaleft "meta left" :exit nil)
  ("r" org-metaright "meta right" :exit nil)
  ("u" org-metaup "meta up" :exit nil)
  ("d" org-metadown "meta down" :exit nil)
  ("L" org-shiftmetaleft "shift meta left" :exit nil)
  ("R" org-shiftmetaright "shift meta right" :exit nil)
  ("U" org-shiftmetaup "shift meta up" :exit nil)
  ("D" org-shiftmetadown "shift meta down" :exit nil))

(defhydra hydra-lsp-mode (:foreign-keys nil :exit t)
  ("r" eglot-reconnect "eglot reconnect" :column "eglot")
  ("b" eglot-rename "eglot rename")
  ("m" eglot-format "eglot format")
  ("o" eglot-code-action-organize-imports "organize imports")
  ("e" eldoc "eldoc"))

(defun cond-keymode-with-modes ()
  "Select the keymap of hydara according to current mode."
  (interactive)
  (when (eq major-mode 'org-mode)
    (hydra-org-mode/body))
  (when (bound-and-true-p eglot--managed-mode)
    (hydra-lsp-mode/body)))

(global-set-key
 (kbd "C-r")
 (defhydra hydra-edit (:foreign-keys nil :exit t)
   ("u" undo "undo" :column "Edit" :exit nil)
   ("U" undo-redo "redo" :exit nil)
   ("h" anzu-query-replace "replace")
   ("H" anzu-query-replace-regexp "replace regexp")
   (";" comment-line "comment line")
   ("C-;" comment-region "comment region")
   ("m" format-all-buffer "format buffer")
   ("~" revert-buffer "revert buffer")
   (":" iedit-mode "iedit")
   ("[" puni-wrap-square "warp []")
   ("{" puni-wrap-curly "wrap {}")
   ("(" puni-wrap-round "wrap ()")
   (")" puni-raise "raise")
   ("i" defined/insert-with-space "insert with space")

   ("gg" goto-line "goto line" :column "Navigate")
   ("gw" avy-goto-word-1 "goto word")
   ("gc" avy-goto-char-2 "goto char2")
   ("v" View-scroll-half-page-forward "page down" :exit nil)
   ("V" View-scroll-half-page-backward "page up" :exit nil)
   ("," goto-last-change "goto last change")
   ("DEL" hungry-delete-backward "hungry delete")
   ("s" ctrlf-forward-default "search forward")
   ("S" ctrlf-forward-alternate "regexp forward")
   ("r" ctrlf-backward-default "search backward")
   ("R" ctrlf-backward-alternate "regexp backward")
   ("b" symbol-overlay-rename "symbol rename")
   ("_" ctrlf-forward-symbol "search symbol")
   ("." ctrlf-forward-symbol-at-point "search symbol as point")
   ("=" er/expand-region "expand region")))

(global-set-key
 (kbd "C-q")
 (defhydra hydra-high-frequency (:foreign-keys nil :exit t)
   ("c" consult-recent-file "recent file" :column "Navigate")
   ("C" consult-bookmark "bookmark")
   ("q" treemacs "treemacs")
   ("d" xref-find-definitions "find definitions")
   ("f" xref-find-references "find references")
   ("w" xref-find-definitions-other-window "references other window")
   ("i" consult-imenu "semantic imenu")
   ("I" consult-imenu-multi "semantic imenu multi")
   ("j" citre-jump "citre jump")
   (";" citre-jump-back "citre jump back")
   ("l" citre-jump-to-reference "citre jump reference")
   ("p" citre-peek "citre peek")
   ("t" citre-peek-through "citre through")
   ("v" vterm "vterm" :column "Tools")
   ("V" projectile-run-vterm "projectile vterm")
   ("s" dash-at-point "dash")
   ("kt" kill-this-buffer "kill this buffer")
   ("kb" kill-buffer "kill other buffer")
   ("kr" eval-buffer "eval buffer")
   ("C-q" cond-keymode-with-modes "conds")

   ("ee" consult-register-store "save register")
   ("er" consult-register-load "load register")
   ("el" consult-register "consult register")
   ("ey" consult-yank-pop "yank pop")
   ("m" consult-kmacro "macros")))

(provide 'init-hydra)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-hydra.el ends here
