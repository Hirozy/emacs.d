;;; init-sequence.el --- key sequence configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; key sequence configuration
;;

;;; Code:

(require 'transient)
(require 'hydra)
(require 'init-defun)

(declare-function agent-shell "agent-shell")
(defvar agent-shell-context-sources)

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
   ("C-;" comment-or-uncomment-region "un/comment region")
   ("m" apheleia-format-buffer "format buffer")
   ("n" defined/new-buffer "new buffer")
   ("~" revert-buffer "revert buffer")
   ("i" (lambda ()
          (interactive)
          (insert-char (char-from-name "SPACE"))
          (backward-char)
          (evil-insert-state)) "insert with space")
   ("TAB" transient-capf "capf TAB")

   ("gg" goto-line "goto line" :column "Navigate")
   ("h" backward-char "left" :exit nil)
   ("j" next-line "down" :exit nil)
   ("k" previous-line "up" :exit nil)
   ("l" forward-char "right" :exit nil)
   ("z" avy-goto-word-1 "goto word")
   ("x" avy-goto-char-2 "goto char2")
   ("v" View-scroll-half-page-forward "page down" :exit nil)
   ("V" View-scroll-half-page-backward "page up" :exit nil)
   ("," goto-last-change "goto last change")
   ("DEL" hungry-delete-backward "hungry delete")
   ("r" symbol-overlay-rename "symbol rename")
   ("=" er/expand-region "expand region")

   ("[" puni-wrap-square "wrap []" :column "Pairs")
   ("{" puni-wrap-curly "wrap {}")
   ("(" puni-wrap-round "wrap ()")
   ("<" puni-wrap-angle "wrap <>")
   (")" puni-raise "raise")
   ("a" puni-beginning-of-sexp "beginning of sexp" :exit nil)
   ("e" puni-end-of-sexp "end of sexp" :exit nil)
   ("b" puni-backward-sexp "backward sexp" :exit nil)
   ("f" puni-forward-sexp "forward sexp" :exit nil)
   ("9" puni-syntactic-backward-punct "next punctuation" :exit nil)
   ("0" puni-syntactic-forward-punct "next punctuation" :exit nil)))

(define-key hydra-editing/keymap (kbd "SPC") 'hydra-keyboard-quit)

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
   ("q" quit-window "quick window")

   ("v" ghostel "ghostel" :column "Tools")
   ("V" ghostel-project "project ghostel")
   ("?" (lambda ()
          (interactive)
          (let ((agent-shell-context-sources nil))
            (agent-shell))) "agent shell")
   ("s" dash-at-point "dash")
   ("kt" kill-current-buffer "kill this buffer")
   ("kb" kill-buffer "kill other buffer")
   ("kr" eval-buffer "eval buffer")
   ("\\" swap-theme "swap theme")
   ("n" transient-org "org keymap" :exit t)))

(define-key hydra-frequently/keymap (kbd "SPC") 'hydra-keyboard-quit)

(with-eval-after-load 'evil-maps
  (evil-define-key '(normal insert) 'global
    (kbd "C-q") 'hydra-frequently/body
    (kbd "C-r") 'hydra-editing/body))

(provide 'init-sequence)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-sequence.el ends here
