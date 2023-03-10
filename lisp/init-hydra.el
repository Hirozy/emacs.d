;;; init-hydra.el --- hydra configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; hydra configuration
;;

;;; Code:

(defhydra org-keys (:foreign-keys nil :exit t)
  "Keymap for org mode and org roam."
  ("f" org-roam-node-find "find node" :column "Org Roam")
  ("c" org-roam-capture "capture")
  ("o" org-roam-node-open "open node")
  ("i" org-roam-node-insert "insert node")
  ("t" org-roam-buffer-toggle "buffer toggle")
  ("n" org-roam-dailies-capture-today "capture today")
  ("p" org-roam-graph "graph")
  ("u" org-roam-ui-open "open ui")
  ("r" org-roam-db-sync "db sync")

  ("RET" org-return "return" :column "Org mode")
  ("s" org-insert-structure-template "org template")
  ("'" org-insert-subheading "insert subheading")
  ("e" org-table-create "create table"))

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
 (defhydra hydra-freq (:foreign-keys nil :exit t)
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
   ("ee" consult-register-store "save register")
   ("er" consult-register-load "load register")
   ("el" consult-register "consult register")
   ("ey" consult-yank-pop "yank pop")
   ("m" consult-kmacro "macros")
   ("," org-keys/body :exit t)))

(provide 'init-hydra)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-hydra.el ends here
