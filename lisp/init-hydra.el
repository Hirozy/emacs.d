;;; init-hydra.el --- hydra configuration

;;; Commentary:
;;
;; hydra configuration
;;

;;; Require
(require 'init-packages)

;;; Code:

(require-packages '(hydra))

(global-set-key
 (kbd "C-r")
 (defhydra hydra-edit (:foreign-keys warn :exit t)
   "
_;_: Comment line    _gg_: Goto line        _\"_: Wrap double quate
_^_: Delete indent   _gl_: Goto line (avy)  _[_: Wrap bracket
_mi_: Format code    _gw_: Goto word-1      _{_: Wrap curly
_t_: Undo tree       _gc_: Goto char-2      _(_: Wrap round
_u_: Undo            _s_: Replace string    _)_: Unwarp
_r_: Redo            _C-s_: Replace regexp
"
   ("dd" kill-whole-line :exit nil)
   ("d$" kill-line :exit nil)
   ("dw" kill-word :exit nil)
   ("u" undo-tree-undo :exit nil)
   ("r" undo-tree-redo :exit nil)
   ("t" undo-tree-visualize)
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
   ("C-s" replace-regexp)
   (";" comment-line)
   ("mi" format-all-buffer)
   ("^" delete-indentation)
   ("\"" awesome-pair-wrap-double-quote)
   ("[" awesome-pair-wrap-bracket)
   ("{" awesome-pair-wrap-curly)
   ("(" awesome-pair-wrap-round)
   (")" awesome-pair-unwrap)
   ("SPC" nil)
   ("<ESC>" nil)
   ("<tab>" nil)
   ("C-c" nil)
   ("C-r" nil)))

(global-set-key
 (kbd "C-q")
 (defhydra hf (:foreign-keys warn :exit t :timeout 3)
   "
_ee_: Python venv       _v_: Evil mode        _p_: Counsel to project
_ep_: Poetry            _m_: Magit status     _b_: Counsel to file (bufer)
_ev_: Poetry venv       _t_: Vterm            _f_: Counsel to file (project)
_kr_: Eval buffer        _q_: Treemacs       _aa_: Tab switch group
_kt_: Kill this buffer   _ww_: Switch view   _,_: Backward tab
_kb_: Kill buffer        _w1_: Push view     _._: Forward tab
_dd_: Find definitions   _w2_: Pop view      _oh_: Org to html
_cr_: Recentf files      _cb_: Bookmark      _os_: Org template
_'_: Org insert subhead
"
   ("cr" counsel-recentf)
   ("cb" counsel-bookmark)
   ("ah" awesome-tab-move-current-tab-to-left :exit nil)
   ("al" awesome-tab-move-current-tab-to-right :exit nil)
   ("a0" awesome-tab-select-beg-tab "Move to beg tab")
   ("a$" awesome-tab-select-end-tab " Move to end tab")
   ("aa" awesome-tab-counsel-switch-group)
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
   ("ee" pyvenv-workon)
   ("ep" poetry)
   ("ev" poetry-venv-workon)
   ("ls" lsp-workspace-restart)
   ("le" eglot-reconnect)
   ("dd" xref-find-definitions)
   ("dw" xref-find-definitions-other-window)
   ("dr" xref-find-references)
   ("df" lsp-find-definition)
   ("ds" lsp-find-references)
   ("di" lsp-find-implementation)
   ("dt" lsp-find-type-definition)
   ("v" evil-mode)
   ("m" magit-status)
   ("t" vterm)
   ("b" counsel-projectile-switch-to-buffer)
   ("p" projectile-switch-project)
   ("f" projectile-find-file)
   ("q" treemacs)
   ("ww" ivy-switch-view)
   ("w1" ivy-push-view)
   ("w2" ivy-pop-view)
   ("oh" org-html-export-to-html)
   ("os" org-insert-structure-template)
   ("ot" org-table-create)
   ("RET" org-insert-heading-respect-content)
   ("'" org-insert-subheading)
   ("SPC" nil)
   ("<ESC>" nil)
   ("<tab>" nil)
   ("C-c" nil)
   ("C-q" nil)))

(global-set-key
 (kbd "C-\\")
 (defhydra hydra-window ()
   "
^Movement^      ^Split^           ^Switch^      ^Resize^
^--------^------^-----^-----------^------^------^------^--
_h_: ←         	_v_ertical        _b_uffer		_q_: X←
_j_: ↓        	_x_:horizontal    _f_ind files	_w_: X↓
_k_: ↑        	_z_:undo          _a_ce 1		_e_: X↑
_l_: →        	_Z_:reset         _s_wap		_r_: X→
_F_ollow        _D_lt Other   	  _S_ave		max_i_mize
_SPC_: cancel   _o_nly this   	  _d_elete
"
   ("h" windmove-left )
   ("j" windmove-down )
   ("k" windmove-up )
   ("l" windmove-right )
   ("q" hydra-move-splitter-left)
   ("w" hydra-move-splitter-down)
   ("e" hydra-move-splitter-up)
   ("r" hydra-move-splitter-right)
   ("b" ivy-switch-buffer)
   ("f" counsel-find-file)
   ("F" follow-mode)
   ("a" (lambda ()
          (interactive)
          (ace-window 1)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body))
    )
   ("v" (lambda ()
          (interactive)
          (split-window-right)
          (windmove-right))
    )
   ("x" (lambda ()
          (interactive)
          (split-window-below)
          (windmove-down))
    )
   ("s" (lambda ()
          (interactive)
          (ace-window 4)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body)))
   ("S" save-buffer)
   ("d" delete-window)
   ("D" (lambda ()
          (interactive)
          (ace-window 16)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body))
    )
   ("o" delete-other-windows)
   ("i" ace-maximize-window)
   ("z" (progn
          (winner-undo)
          (setq this-command 'winner-undo))
    )
   ("Z" winner-redo)
   ("SPC" nil)
   ))

(provide 'init-hydra)

;;; init-hydra.el ends here
