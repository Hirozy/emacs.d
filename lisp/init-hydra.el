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
  "
_<_: Meta left         _>_: Meta right          _s_: Insert template
_l_: Meta left         _L_: Shift meta left     _h_: Export to html
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

(defhydra hydra-lsp-mode (:foreign-keys warn :exit t)
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
_u_: Undo              _gc_: Goto char-2        _(_: Wrap round
_u_: Redo              _s_: Replace string      _)_: Unwarp
_S_: Replace regexp    _~_: Reload file         _:_: iedit-mode
_v_: Scroll down       _V_: Scroll up           _z_: Zzz to char
_,_: Goto change       _._: Goto change (r)     _Z_: Zzz up to char
"
   ("u" undo-fu-only-undo :exit nil)
   ("U" undo-fu-only-redo)
   ("n" next-line :exit nil)
   ("p" previous-line :exit nil)
   ("f" forward-char :exit nil)
   ("F" forward-word :exit nil)
   ("b" backward-char :exit nil)
   ("B" backward-word :exit nil)
   ("0" beginning-of-line :exit nil)
   ("$" move-end-of-line :exit nil)
   ("z" zzz-to-char)
   ("Z" zzz-up-to-char)
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
   ("\"" grammatical-edit-wrap-double-quote)
   ("[" grammatical-edit-wrap-bracket)
   ("{" grammatical-edit-wrap-curly)
   ("(" grammatical-edit-wrap-round)
   (")" grammatical-edit-unwrap)
   (":" iedit-mode)
   ("v" View-scroll-half-page-forward :exit nil)
   ("V" View-scroll-half-page-backward :exit nil)
   ("," goto-last-change)
   ("." goto-last-change-reverse :exit nil)
   ("DEL" hungry-delete-backward)
   ("C-r" ctrlf-backward-default)
   ("C-h" anzu-query-replace)
   ("RET" nil)
   ("SPC" nil)
   ("<ESC>" nil)
   ("C-c" nil)))

(defhydra hydra-low-frequency (:foreign-keys warn :exit t)
  "
_ah_: Move tab to left       _ww_: Switch view      _f_: Show file path
_al_: Move tab to right      _w1_: Push view        _c_: Projectile async run
_a0_: Move tab to begin      _w2_: Pop view         _p_: poetry
_a$_: Move tab to end        _s_: Awesome pair      _P_: pyvenv workon
_aa_: Switch tab group       _u_: UUID
_o_: Xterm mouse             _r_: Readonly
"
  ("ah" awesome-tab-move-current-tab-to-left :exit nil)
  ("al" awesome-tab-move-current-tab-to-right :exit nil)
  ("a0" awesome-tab-select-beg-tab)
  ("a$" awesome-tab-select-end-tab)
  ("aa" awesome-tab-counsel-switch-group)
  ("ww" ivy-switch-view)
  ("w1" ivy-push-view)
  ("w2" ivy-pop-view)
  ("u" uuidgen)
  ("s" grammatical-edit-mode)
  ("p" poetry)
  ("P" pyvenv-workon)
  ("f" defined/get-buffer-file-name)
  ("c" projectile-run-async-shell-command-in-root)
  ("r" projectile-toggle-project-read-only)
  ("o" xterm-mouse-mode)
  ("C-l" nil)
  ("C-c" nil)
  ("SPC" nil))

(global-set-key
 (kbd "C-q")
 (defhydra hydra-high-frequency (:foreign-keys warn :exit t)
   "
_p_: Counsel to project           _,_: Backward tab        _i_: Semantic       _C-q_: Cond mode
_b_: Counsel to file (bufer)      _._: Forward tab         _I_: imenu          _C-w_: Low frequency
_f_: Counsel to file (project)    _d_: Xref definition     _t_: Vterm          _C-p_: Multiple cursors
_c_: Counsel recentf              _r_: Xref references     _T_: Vterm Projectile
_C_: Counsel bookmark             _w_: Definition new
_kr_: Eval buffer                 _a_: Xref apropos
_kt_: Kill this buffer            _/_: Awesome pair
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
   ("/" grammatical-edit-mode)
   ("kt" kill-this-buffer)
   ("kb" kill-buffer)
   ("kr" eval-buffer)
   ("v" evil-mode "Evil")
   ("b" counsel-projectile-switch-to-buffer)
   ("p" projectile-switch-project)
   ("f" projectile-find-file)
   ("q" treemacs "Treemace")
   ("d" xref-find-definitions)
   ("r" xref-find-references)
   ("w" xref-find-definitions-other-window)
   ("a" xref-find-apropos)
   ("i" counsel-semantic-or-imenu)
   ("I" counsel-imenu)
   ("t" vterm)
   ("T" projectile-run-vterm)
   ("C-p" hydra-multiple-cursors/body)
   ("C-w" hydra-low-frequency/body)
   ("C-q" cond-keymode-with-modes)
   ("SPC" nil)
   ("<ESC>" nil)
   ("C-c" nil)))

(provide 'init-hydra)

;;; init-hydra.el ends here
