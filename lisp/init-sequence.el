;;; init-sequence.el --- key sequence configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; key sequence configuration
;;

;;; Code:

(require 'transient)

(transient-define-prefix transient-capf ()
  "Completion At Point Functions.
Select a completion backend to trigger at the current point."
  ["capf TAB"
   ("q" "Tempel expand" tempel-expand)
   ("w" "Cape dabbrev" cape-dabbrev)
   ("e" "Cape dict" cape-dict)
   ("r" "Cape tex" cape-tex)]
  [("SPC" "Quit" transient-quit-all)])

(transient-define-prefix transient-editing ()
  "Editing Commands.
Undo/redo, search and replace, commenting, formatting, and structural editing."
  [["Edit"
    ("u" "Undo" undo-fu-only-undo :transient t)
    ("U" "Redo" undo-fu-only-redo :transient t)
    ("C-u" "Redo all" undo-fu-only-redo-all)
    ("M-u" "Visual undo tree" vundo)
    ("h" "Replace string" replace-string)
    ("H" "Replace regexp" query-replace-regexp)
    (";" "Comment line" comment-line)
    ("C-;" "Comment region" comment-region)
    ("m" "Format buffer" apheleia-format-buffer)
    ("~" "Revert buffer" revert-buffer)
    ("[" "Wrap []" puni-wrap-square)
    ("{" "Wrap {}" puni-wrap-curly)
    ("(" "Wrap ()" puni-wrap-round)
    (")" "Raise sexp" puni-raise)
    ("i" "Insert with space" (lambda ()
                               (interactive)
                               (insert-char (char-from-name "SPACE"))
                               (backward-char)
                               (evil-insert-state)))
    ("TAB" "Capf TAB" transient-capf)]
   ["Navigate"
    ("gg" "Goto line" goto-line)
    ("z" "Goto word" avy-goto-word-1)
    ("x" "Goto char2" avy-goto-char-2)
    ("v" "Page down" View-scroll-half-page-forward :transient t)
    ("V" "Page up" View-scroll-half-page-backward :transient t)
    ("," "Goto last change" goto-last-change)
    ("DEL" "Hungry delete backward" hungry-delete-backward)
    ("r" "Symbol rename" symbol-overlay-rename)
    ("=" "Expand region" er/expand-region)]]
  [("SPC" "Quit" transient-quit-all)])

(global-set-key (kbd "C-r") #'transient-editing)

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

(autoload 'eglot-find-implementation "eglot")
(autoload 'eglot-find-typeDefinition "eglot")
(transient-define-prefix transient-frequently ()
  "Frequently Used Commands.
Navigation, code intelligence, project tools, and utilities."
  [["Navigate"
    ("c" "Recent file" consult-recent-file)
    ("m" "Bookmarks" transient-bookmark)
    ("d" "Find definitions" xref-find-definitions)
    ("f" "Find references" xref-find-references)
    ("w" "Definitions other window" xref-find-definitions-other-window)
    ("o" "Find implementation" eglot-find-implementation)
    ("p" "Find type definition" eglot-find-typeDefinition)
    ("l" "Dired jump to file" dired-jump)
    ("i" "Semantic imenu" consult-imenu)
    ("I" "Semantic multiple imenu" consult-imenu-multi)
    ("j" "Tags keymap" transient-tags)
    ("e" "Registers and yanks" transient-register-yank-macros)]
   ["Tools"
    ("v" "Vterm" vterm)
    ("V" "Projectile vterm" projectile-run-vterm)
    ("s" "Dash documentation" dash-at-point)
    ("g" "GPTel menu" gptel-menu)
    ("kt" "Kill this buffer" kill-current-buffer)
    ("kb" "Kill other buffer" kill-buffer)
    ("kr" "Eval buffer" eval-buffer)
    ("\\" "Swap theme" swap-theme)
    ("n" "Org keymap" transient-org)]]
  [("SPC" "Quit" transient-quit-all)])

(global-set-key (kbd "C-q") #'transient-frequently)

(provide 'init-sequence)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-sequence.el ends here
