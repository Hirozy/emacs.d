;;; init-sequence.el --- key sequence configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; key sequence configuration
;;

;;; Code:

(require 'transient)
(require 'hydra)

(transient-define-prefix transient-capf ()
  "Completion At Point Functions.
Select a completion backend to trigger at the current point."
  ["capf TAB"
   ("q" "Tempel expand" tempel-expand)
   ("w" "Cape dabbrev" cape-dabbrev)
   ("e" "Cape dict" cape-dict)
   ("r" "Cape tex" cape-tex)]
  [("SPC" "Quit" transient-quit-all)])

(global-set-key
 (kbd "C-r")
 (defhydra hydra-editing (:foreign-keys warn :exit t)
   ("u" undo-fu-only-undo "undo" :column "Edit" :exit nil)
   ("U" undo-fu-only-redo "redo" :exit nil)
   ("C-u" undo-fu-only-redo-all "redo all")
   ("M-u" vundo "vision undo")
   ("h" replace-string "replace")
   ("H" query-replace-regexp "replace regexp")
   (";" comment-line "comment line")
   ("C-;" comment-region "comment region")
   ("m" apheleia-format-buffer "format buffer")
   ("~" revert-buffer "revert buffer")
   ("[" puni-wrap-square "warp []")
   ("{" puni-wrap-curly "wrap {}")
   ("(" puni-wrap-round "wrap ()")
   (")" puni-raise "raise")
   ("i" (lambda ()
          (interactive)
          (insert-char (char-from-name "SPACE"))
          (backward-char)
          (evil-insert-state)) "insert with space")
   ("TAB" transient-capf "capf TAB")

   ("gg" goto-line "goto line" :column "Navigate")
   ("z" avy-goto-word-1 "goto word")
   ("x" avy-goto-char-2 "goto char2")
   ("v" View-scroll-half-page-forward "page down" :exit nil)
   ("V" View-scroll-half-page-backward "page up" :exit nil)
   ("," goto-last-change "goto last change")
   ("DEL" hungry-delete-backward "hungry delete")
   ("r" symbol-overlay-rename "symbol rename")
   ("=" er/expand-region "expand region")
   ("SPC" nil "quit")))

(transient-define-prefix transient-tags ()
  "Tags Navigation and Management.
Jump to definitions and references using Citre, and manage ctags/gtags databases."
  [["Citre"
    ("j" "Citre jump" citre-jump)
    ("l" "Citre jump to reference" citre-jump-to-reference)
    ("b" "Citre jump back" citre-jump-back)
    ("p" "Citre peek" citre-peek)
    ("t" "Citre peek through" citre-peek-through)]
   ["Update"
    ("u" "Update ctags file" citre-update-this-tags-file)
    ("U" "Update gtags database" citre-global-update-database)
    ("c" "Create ctags file" citre-create-tags-file)
    ("C" "Create gtags database" citre-global-create-database)]]
  [("SPC" "Quit" transient-quit-all)])

(transient-define-prefix transient-bookmark ()
  "Bookmark Management.
List, add, and edit bookmarks for quick file navigation."
  ["Bookmarks"
   ("/" "List bookmarks" consult-bookmark)
   ("m" "Add bookmark" bookmark-set)
   ("e" "Edit bookmarks" edit-bookmarks)]
  [("SPC" "Quit" transient-quit-all)])

(transient-define-prefix transient-register-yank-macros ()
  "Registers, Yank Ring and Macros.
Store, load, and browse registers; access kill ring and yank history;
and access defined Keyboard macros"
  [["Registers"
    ("s" "Save register" consult-register-store)
    ("l" "Load register" consult-register-load)
    ("/" "Consult register" consult-register)]
   ["Yanks"
    ("p" "Yank pop" consult-yank-pop)
    ("y" "Yank from kill ring" consult-yank-from-kill-ring)]
   ["Macros"
    ("m" "List macros" consult-kmacro)]]
  [("SPC" "Quit" transient-quit-all)])

(transient-define-prefix transient-org ()
  "Org Mode and Denote.
Manage notes with Denote, export and edit Org documents, handle attachments."
  [["Denote"
    ("n" "Open or create note" denote-open-or-create)
    ("o" "New note" denote)
    ("r" "Rename file using front matter" denote-rename-file-using-front-matter)
    ("l" "Denote link" denote-link)
    ("b" "Denote backlinks" denote-backlinks)
    ("/" "Search notes" consult-denote-find)
    ("s" "Search content" consult-denote-grep)
    ("h" "Search heading" consult-org-heading)]
   ["Org Mode"
    ("S" "Org structure template" org-insert-structure-template)
    ("e" "Org export" org-export-dispatch)
    ("yy" "Yank media" yank-media)
    ("yd" "Delete attachment" org-attach-delete-one)
    ("ys" "Sync attachments" org-attach-sync)
    ("'" "Insert subheading" org-insert-subheading)
    ("c" "Copy to shell cat" org-copy-to-shell-cat)
    ("T" "Create table" org-table-create)
    ("I" "Create ID" org-id-get-create)]]
  [("SPC" "Quit" transient-quit-all)])

(global-set-key
 (kbd "C-q")
 (defhydra hydra-frequently (:foreign-keys warn :exit t)
   ("c" consult-recent-file "recent file" :column "Navigate")
   ("m" transient-bookmark  "bookmark")
   ("d" xref-find-definitions "find definitions")
   ("f" xref-find-references "find references")
   ("w" xref-find-definitions-other-window "definitions other window")
   ("o" eglot-find-implementation "find implementation")
   ("p" eglot-find-typeDefinition "find type definition")
   ("l" dired-jump "dired jump to file")
   ("i" consult-imenu "semantic imenu")
   ("I" consult-imenu-multi "semantic multiple imenu")
   ("j" transient-tags "tags keymap" :exit t)
   ("e" transient-register-yank-macros "register, yank and macros")

   ("v" vterm "vterm" :column "Tools")
   ("V" projectile-run-vterm "projectile vterm")
   ("s" dash-at-point "dash")
   ("kt" kill-current-buffer "kill this buffer")
   ("kb" kill-buffer "kill other buffer")
   ("kr" eval-buffer "eval buffer")
   ("\\" swap-theme "swap theme")
   ("n" transient-org "org keymap" :exit t)
   ("SPC" nil "quit")))

(provide 'init-sequence)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-sequence.el ends here
