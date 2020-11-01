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

(defhydra hydra-org-mode (:foreign-keys warn :exit t :timeout 3)
  "
_<_: Meta left         _>_: Meta right          _s_: Insert template
_l_: Meta left         _L_: Shift meta left     _t_: Export to html
_r_: Meta right        _R_: Shift meta right    _t_: Insert table
_u_: Meta up           _U_: Shift meta up       _i_: Indent mode
_d_: Meta down         _D_: Shift meta down     _'_: Insert subhead
_RET_: Respect heading
"
  ("s" org-insert-structure-template)
  ("h" org-html-export-to-html)
  ("t" org-table-create)
  ("i" org-indent-mode)
  ("<" org-metaleft :exit nil)
  (">" org-metaright :exit nil)
  ("l" org-metaleft :exit nil)
  ("r" org-metaright :exit nil)
  ("u" org-metaup :exit nil)
  ("d" org-metadown :exit nil)
  ("L" org-shiftmetaleft :exit nil)
  ("R" org-shiftmetaright :exit nil)
  ("U" org-shiftmetaup :exit nil)
  ("D" org-shiftmetadown :exit nil)
  ("RET" org-insert-heading-respect-content)
  ("'" org-insert-subheading)
  ("SPC" nil)
  ("<ESC>" nil)
  ("C-c" nil)
  ("C-q" nil))

(defhydra hydra-lsp-mode (:foreign-keys warn :exit t :timeout 3)
  "
_d_: lsp definition         _s_: Restart lsp-mode
_r_: lsp references         _S_: Restart eglot
_t_: lsp type definition
_i_: lsp implementation
"
  ("d" lsp-find-definition)
  ("r" lsp-find-references)
  ("i" lsp-find-implementation)
  ("t" lsp-find-type-definition)
  ("s" lsp-workspace-restart)
  ("S" eglot-reconnect)
  ("v" pyvenv-workon)
  ("p" poetry)
  ("SPC" nil)
  ("<ESC>" nil)
  ("C-c" nil)
  ("C-q" nil))

(defun cond-keymode-with-modes ()
  "Select the keymap of hydara according to current mode."
  (interactive)
  (cond ((member major-mode '(org-mode))
         (hydra-org-mode/body))
        ((member major-mode '(c-mode c++-mode python-mode))
         (hydra-lsp-mode/body))
        (t
         nil)))


(global-set-key
 (kbd "C-r")
 (defhydra hydra-edit (:foreign-keys warn :exit t)
   "
_;_: Comment line      _gg_: Goto line          _\"_: Wrap double quate
_^_: Delete indent     _gl_: Goto avy line      _[_: Wrap bracket
_m_: Format code       _gw_: Goto word-1        _{_: Wrap curly
_U_: Undo tree         _gc_: Goto char-2        _(_: Wrap round
_u_: Undo              _s_: Replace string      _)_: Unwarp
_r_: Redo              _S_: Replace regexp      _~_: Reload file
_v_: Scroll down       _:_: iedit-mode          _`_: Normal mode
_V_: Scroll up
"
   ("dd" kill-whole-line :exit nil)
   ("d$" kill-line :exit nil)
   ("dw" kill-word :exit nil)
   ("u" undo-tree-undo :exit nil)
   ("r" undo-tree-redo :exit nil)
   ("U" undo-tree-visualize)
   ("n" next-line :exit nil)
   ("p" previous-line :exit nil)
   ("f" forward-char :exit nil)
   ("F" forward-word :exit nil)
   ("b" backward-char :exit nil)
   ("B" backward-word :exit nil)
   ("0" beginning-of-line :exit nil)
   ("$" move-end-of-line :exit nil)
   ("i" nil)
   ("o" crux-smart-open-line)
   ("O" crux-smart-open-line-above)
   ("gg" goto-line)
   ("gl" avy-goto-line)
   ("gw" avy-goto-word-1)
   ("gc" avy-goto-char-2)
   ("s" replace-string)
   ("S" replace-regexp)
   (";" comment-line)
   ("m" format-all-buffer)
   ("^" delete-indentation)
   ("~" revert-buffer)
   ("`" normal-mode)
   ("\"" awesome-pair-wrap-double-quote)
   ("[" awesome-pair-wrap-bracket)
   ("{" awesome-pair-wrap-curly)
   ("(" awesome-pair-wrap-round)
   (")" awesome-pair-unwrap)
   (":" iedit-mode)
   ("v" View-scroll-half-page-forward :exit nil)
   ("V" View-scroll-half-page-backward :exit nil)
   ("SPC" nil)
   ("<ESC>" nil)
   ("C-c" nil)
   ("C-r" nil)))

(defhydra hydra-low-frequency (:foreign-keys warn :exit t :timeout 5)
  "
_ah_: Move tab to left       _ww_: Switch view      _t_: Vterm
_al_: Move tab to right      _w1_: Push view        _u_: UUID
_a0_: Move tab to begin      _w2_: Pop view         ^ ^
_a$_: Move tab to end        _p_: Awesome pair      ^ ^
_aa_: Switch tab group       _l_: File path
"
  ("ah" awesome-tab-move-current-tab-to-left :exit nil)
  ("al" awesome-tab-move-current-tab-to-right :exit nil)
  ("a0" awesome-tab-select-beg-tab)
  ("a$" awesome-tab-select-end-tab)
  ("aa" awesome-tab-counsel-switch-group)
  ("ww" ivy-switch-view)
  ("w1" ivy-push-view)
  ("w2" ivy-pop-view)
  ("t" vterm)
  ("u" uuidgen)
  ("p" awesome-pair-mode)
  ("l" defined/get-buffer-file-name)
  ("C-c" nil)
  ("SPC" nil))

(require 'multiple-cursors)

(defhydra hydra-multiple-cursors (:hint nil)
  "
 Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search      [_q_] Quit
 [_|_] Align with input CHAR       [Click] Cursor at point"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("|" mc/vertical-align)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("<mouse-1>" mc/add-cursor-on-click)
  ;; Help with click recognition in this hydra
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
  ("q" nil)
  ("C-c" nil))

(global-set-key
 (kbd "C-q")
 (defhydra hydra-high-frequency (:foreign-keys warn :exit t :timeout 3)
   "
_p_: Counsel to project           _,_: Backward tab
_b_: Counsel to file (bufer)      _._: Format tab
_f_: Counsel to file (project)    _d_: Xref definition
_c_: Counsel recentf              _r_: Xref references
_C_: Counsel bookmark             _w_: Definition new
_kr_: Eval buffer                 _a_: Xref apropos
_kt_: Kill this buffer            _/_: Awesome pair
_kr_: Eval buffer
"
   ("c" counsel-recentf)
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
   ("/" awesome-pair-mode)
   ("kt" kill-this-buffer)
   ("kb" kill-buffer)
   ("kr" eval-buffer)
   ("v" evil-mode "Evil")
   ("m" magit-status "Magit")
   ("b" counsel-projectile-switch-to-buffer)
   ("p" projectile-switch-project)
   ("f" projectile-find-file)
   ("q" treemacs "Treemace")
   ("d" xref-find-definitions)
   ("r" xref-find-references)
   ("w" xref-find-definitions-other-window)
   ("a" xref-find-apropos)
   ("C-m" hydra-multiple-cursors/body)
   ("C-l" hydra-low-frequency/body)
   ("C-q" cond-keymode-with-modes)
   ("SPC" cond-keymode-with-modes)
   ("<ESC>" nil)
   ("C-c" nil)))

(provide 'init-hydra)

;;; init-hydra.el ends here
