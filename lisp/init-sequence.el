;;; init-sequence.el --- key sequence configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; key sequence configuration
;;

;;; Code:

(defhydra capf-mapping (:foreign-keys nil :exit t)
  ("1" tempel-expand "tempel expand" :column "capf TAB")
  ("2" cape-dabbrev "cape dabbrev")
  ("3" cape-dict "cape dict")
  ("4" cape-tex "cape tex")
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
   ("i" (lambda ()
          (interactive)
          (insert-char (char-from-name "SPACE"))
          (backward-char)
          (evil-insert-state)) "insert with space")
   ("TAB" capf-mapping/body "capf TAB")

   ("gg" goto-line "goto line" :column "Navigate")
   ("1" avy-goto-word-1 "goto word")
   ("2" avy-goto-char-2 "goto char2")
   ("v" View-scroll-half-page-forward "page down" :exit nil)
   ("V" View-scroll-half-page-backward "page up" :exit nil)
   ("," goto-last-change "goto last change")
   ("DEL" hungry-delete-backward "hungry delete")
   ("r" symbol-overlay-rename "symbol rename")
   ("=" er/expand-region "expand region")
   ("SPC" nil "quit")))


(defhydra tags-mapping (:foreign-keys nil :exit t)
  ("j" citre-jump "citre jump" :column "Citre")
  ("l" citre-jump-to-reference "citre jump to reference")
  ("p" citre-peek "citre peek")
  ("t" citre-peek-through "citre through")
  ("u" citre-update-this-tags-file "update ctags" :column "Update")
  ("U" citre-global-update-database "update gtags")
  ("SPC" nil "quit"))

(defhydra bookmark-mapping (:foreign-keys nil :exit t)
  ("/" consult-bookmark "list bookmarks" :column "Bookmarks")
  ("m" bookmark-set "add bookmark")
  ("e" edit-bookmarks "edit bookmarks")
  ("SPC" nil "quit"))

(defhydra register-mapping (:foreign-keys nil :exit t)
  ("s" consult-register-store "save register" :column "Registers")
  ("l" consult-register-load "load register")
  ("/" consult-register "consult register")

  ("p" consult-yank-pop "yank pop" :column "Yanks")
  ("y" consult-yank-from-kill-ring "yank")
  ("SPC" nil "quit"))

(defhydra org-mapping (:foreign-keys nil :exit t)
  "Keymap for org mode and org roam"
  ("o" denote-open-or-create "find node" :column "Denote")
  ("n" denote "new node")
  ("r" denote-rename-file-using-front-matter "rename file")
  ("tt" denote-keywords-add "tag add")
  ("tr" denote-keywords-remove "tag remove")

  ("S" org-insert-structure-template "org template" :column "Org mode")
  ("'" org-insert-subheading "insert subheading")
  ("c" org-copy-to-shell-cat "copy shell cat")
  ("C" org-babel-insert-tee-file-mark "insert tee mark")
  ("T" org-table-create "create table")
  ("I" org-id-get-create "create ID")
  ("SPC" nil "quit"))

(global-set-key
 (kbd "C-q")
 (defhydra hydra-freq (:foreign-keys nil :exit t)
   ("c" consult-recent-file "recent file" :column "Navigate")
   ("m" bookmark-mapping/body "bookmark")
   ("d" xref-find-definitions "find definitions")
   ("f" xref-find-references "find references")
   ("w" xref-find-definitions-other-window "definitions other window")
   ("o" eglot-find-implementation "find implementation")
   ("p" eglot-find-typeDefinition "find type definition")
   ("l" dired-jump "dired jump to file")
   ("i" consult-imenu "semantic imenu")
   ("I" consult-imenu-multi "semantic imenu multi")
   ("j" tags-mapping/body "tags keymap" :exit t)
   ("q" consult-kmacro "macros")
   ("e" register-mapping/body "register")

   ("v" vterm "vterm" :column "Tools")
   ("V" projectile-run-vterm "projectile vterm")
   ("s" dash-at-point "dash")
   ("kt" kill-current-buffer "kill this buffer")
   ("kb" kill-buffer "kill other buffer")
   ("kr" eval-buffer "eval buffer")
   ("/" swap-theme "swap theme")
   ("n" org-mapping/body "org keymap" :exit t)
   ("SPC" nil "quit")))

(provide 'init-sequence)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-sequence.el ends here
