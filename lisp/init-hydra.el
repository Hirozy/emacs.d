;;; init-hydra.el --- hydra configuration

;;; Commentary:
;;
;; hydra configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(hydra
                    ace-window))

(defhydra hydra-org-mode (:foreign-keys warn :exit t)
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
  ("D" org-shiftmetadown "shift meta down" :exit nil)
  ("SPC" nil "quit")
  ("C-q" nil "quit"))

(defhydra hydra-lsp-mode (:foreign-keys warn :exit t)
  ("d" lsp-find-definition "find defined" :column "LSP")
  ("r" lsp-find-references "find references")
  ("i" lsp-find-implementation "find implementation")
  ("t" lsp-find-type-definition "find type definition")
  ("s" lsp-workspace-restart "lsp restart")
  ("SPC" nil "quit")
  ("C-q" nil "quit"))

(defun cond-keymode-with-modes ()
  "Select the keymap of hydara according to current mode."
  (interactive)
  (if (eq major-mode 'org-mode)
      (hydra-org-mode/body))
  (if (bound-and-true-p lsp-mode)
      (hydra-lsp-mode/body)))

(global-set-key
 (kbd "C-r")
 (defhydra hydra-edit (:foreign-keys warn :exit t)
   ("u" undo-fu-only-undo "undo" :column "Edit" :exit nil)
   ("U" undo-fu-only-redo "redo" :exit nil)
   ("h" anzu-query-replace "replace")
   ("H" anzu-query-replace-regexp "replace regexp")
   (";" comment-line "comment line")
   ("C-;" comment-region "comment region")
   ("m" format-all-buffer "format buffer")
   ("~" revert-buffer "revert buffer")
   (":" iedit-mode "iedit")
   ("`" normal-mode "vim normal")
   ("\"" grammatical-edit-wrap-double-quote "warp \"\"")
   ("'" grammatical-edit-wrap-single-quote "warp ''")
   ("[" grammatical-edit-wrap-bracket "warp []")
   ("{" grammatical-edit-wrap-curly "warp {}")
   ("(" grammatical-edit-wrap-round "warp ()")
   (")" grammatical-edit-unwrap "unwarp")
   ("RET" grammatical-edit-jump-out-pair-and-newline "jump and newline")

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
   ("=" er/expand-region "expand region")

   ("C-r" nil "exit")
   ("SPC" nil "exit")))

(defhydra hydra-low-frequency (:foreign-keys warn :exit t)
  ("ah" awesome-tab-move-current-tab-to-left "move tab to left" :column "View" :exit nil)
  ("al" awesome-tab-move-current-tab-to-right "move tab to right" :exit nil)
  ("a0" awesome-tab-select-beg-tab "select first tab")
  ("a$" awesome-tab-select-end-tab "select last tab")
  ("aa" awesome-tab-counsel-switch-group "switch tab group")
  ("ww" ivy-switch-view "switch view")
  ("w1" ivy-push-view "push view")
  ("w2" ivy-pop-view "pop view")
  ("u" uuidgen "uuidgen" :column "Fun")
  ("p" poetry "poetry")
  ("P" pyvenv-workon "poetry workon")
  ("f" defined/get-buffer-file-name "get file name")
  ("c" projectile-run-async-shell-command-in-root "async run command")
  ("r" projectile-toggle-project-read-only "project readonly")
  ("o" xterm-mouse-mode "xterm mouse")
  ("SPC" nil "exit"))

(global-set-key
 (kbd "C-q")
 (defhydra hydra-high-frequency (:foreign-keys warn :exit t)
   "
_p_: counsel to project           _,_: backward tab        _i_: semantic
_b_: counsel to file (bufer)      _._: forward tab         _I_: imenu
_f_: counsel to file (project)    _d_: xref definition     _t_: vterm
_c_: counsel recentf              _r_: xref references     _T_: vterm Projectile
_C_: counsel bookmark             _w_: definition new
_kr_: eval buffer                 _kt_: kill this buffer
"
   ("c" counsel-buffer-or-recentf)
   ("C" counsel-bookmark)
   ("," awesome-tab-backward-tab :exit nil)
   ("." awesome-tab-forward-tab :exit nil)
   ("1" awesome-tab-select-visible-tab)
   ("2" awesome-tab-select-visible-tab)
   ("3" awesome-tab-select-visible-tab)
   ("4" awesome-tab-select-visible-tab)
   ("5" awesome-tab-select-visible-tab)
   ("6" awesome-tab-select-visible-tab)
   ("7" awesome-tab-select-visible-tab)
   ("8" awesome-tab-select-visible-tab)
   ("9" awesome-tab-select-visible-tab)
   ("0" awesome-tab-select-visible-tab)
   ("kt" kill-this-buffer)
   ("kb" kill-buffer)
   ("kr" eval-buffer)
   ("v" evil-mode)
   ("b" counsel-projectile-switch-to-buffer)
   ("p" projectile-switch-project)
   ("f" projectile-find-file)
   ("q" treemacs)
   ("d" xref-find-definitions)
   ("r" xref-find-references)
   ("w" xref-find-definitions-other-window)
   ("i" counsel-semantic-or-imenu)
   ("I" counsel-imenu)
   ("t" vterm)
   ("T" projectile-run-vterm)
   ("C-w" hydra-low-frequency/body)
   ("C-q" cond-keymode-with-modes)
   ("SPC" nil)))

(provide 'init-hydra)

;;; init-hydra.el ends here
