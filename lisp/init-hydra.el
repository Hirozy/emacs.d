;;; init-hydra.el --- hydra configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; hydra configuration
;;

;;; Code:

(defhydra tags-keys (:foreign-keys nil :exit t)
  "Heymap for tags"
  ("j" citre-jump "citre jump" :column "Citre")
  ("l" citre-jump-to-reference "citre jump to reference")
  ("p" citre-peek "citre peek")
  ("t" citre-peek-through "citre through")
  ("u" citre-update-this-tags-file "update ctags")
  ("U" citre-global-update-database "update gtags")
  ("SPC" nil "quit"))

(defhydra org-keys (:foreign-keys nil :exit t)
  "Keymap for org mode and org roam"
  ("n" org-roam-node-find "find node" :column "Org Roam")
  ("p" org-roam-capture "capture")
  ("o" org-roam-node-open "open node")
  ("i" org-roam-node-insert "insert node")
  ("l" org-roam-buffer-toggle "buffer toggle")
  ("j" org-roam-dailies-capture-today "capture today")
  ("g" org-roam-graph "graph")
  ("u" org-roam-ui-open "open ui")
  ("s" org-roam-db-sync "db sync")

  ("S" org-insert-structure-template "org template" :column "Org mode")
  ("'" org-insert-subheading "insert subheading")
  ("c" org-copy-to-shell-cat "copy shell cat")
  ("C" org-babel-insert-tee-file-mark "insert tee mark")
  ("T" org-table-create "create table")
  ("I" org-id-get-create "create ID")
  ("aa" org-roam-alias-add "alias add")
  ("ar" org-roam-alias-remove "alias remove")
  ("tt" org-roam-tag-add "tag add")
  ("tr" org-roam-tag-remove "tag remove")

  ("e" consult-org-roam-file-find "find file" :column "Func")
  ("b" consult-org-roam-backlinks "org backlinks")
  ("f" consult-org-roam-forward-links "org forward links")
  ("r" consult-org-roam-search "org roam search")
  ("SPC" nil "quit"))

(global-set-key
 (kbd "C-r")
 (defhydra hydra-edit (:foreign-keys nil :exit t)
   ("u" undo-fu-only-undo "undo" :column "Edit" :exit nil)
   ("U" undo-fu-only-redo "redo" :exit nil)
   ("C-u" undo-fu-only-redo-all "redo all")
   ("M-u" vundo "vision undo")
   ("h" replace-string "replace")
   ("H" query-replace-regexp "replace regexp")
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
   ("SPC" nil "quit")

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
   ("j" tags-keys/body "tags keymap" :exit t)
   ("m" consult-kmacro "macros")
   ("SPC" nil "quit")

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
   ("/" swap-theme "swap theme")
   ("n" org-keys/body "org keymap" :exit t)))

(provide 'init-hydra)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-hydra.el ends here
