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
 (defhydra hydra-edit (:foreign-keys warn)
   "
_;_: Comment line    _mi_: Format code       _6_: Delete indentation
_gl_: Goto line      _gw_: Goto word-1       _gc_: Goto char-2
"
   ("dd" kill-whole-line)
   ("d$" kill-line)
   ("dw" kill-word)
   ("u" undo-tree-undo)
   ("r" undo-tree-redo)
   ("n" next-line)
   ("p" previous-line)
   ("f" forward-char)
   ("F" forward-word)
   ("b" backward-char)
   ("B" backward-word)
   ("0" beginning-of-line)
   ("$" move-end-of-line)
   ("i" nil)
   ("o" crux-smart-open-line :exit t)
   ("O" crux-smart-open-line-above :exit t)
   ("gl" avy-goto-line :exit t)
   ("gw" avy-goto-word-1 :exit t)
   ("gc" avy-goto-char-2 :exit t)
   (";" comment-line :exit t)
   ("mi" format-all-buffer :exit t)
   ("6" delete-indentation :exit t)
   ("SPC" nil)
   ("<ESC>" nil)
   ("<tab>" nil)
   ("C-c" nil)))

(global-set-key
 (kbd "C-q")
 (defhydra hf (:foreign-keys warn :exit t :timeout 1)
   "
_ee_: Python venv      _v_: Evil mode          _p_: Counsel to project
_ep_: Poetry           _m_: Magit status       _b_: Counsel to file (bufer)
_ev_: Poetry venv      _t_: Vterm              _f_: Counsel to file (project)
_lr_: lsp restart      _q_: Treemacs           _aa_: Tab ace jump
_kt_: Kill this buffer _ww_: Switch view       _as_: Tab switch group
_kb_: Kill buffer      _w1_: Push view         _,_: Backward tab
_kr_: Eval buffer      _w2_: Pop view          _._: Forward tab
"
   ("cr" counsel-recentf "counsel-recentf")
   ("cb" counsel-bookmark "counsel-bookmark")
   ("ah" awesome-tab-move-current-tab-to-left "Move tab to left" :exit nil)
   ("al" awesome-tab-move-current-tab-to-right "Move tab to right" :exit nil)
   ("a0" awesome-tab-select-beg-tab "Move to beg tab")
   ("a$" awesome-tab-select-end-tab " Move to end tab")
   ("ak" awesome-tab-kill-other-buffers-in-current-group "Kill other buffers")
   ("aa" awesome-tab-ace-jump)
   ("as" awesome-tab-counsel-switch-group)
   ("," awesome-tab-backward-tab :exit nil)
   ("." awesome-tab-forward-tab :exit nil)
   ("kt" kill-this-buffer)
   ("kb" kill-buffer)
   ("kr" eval-buffer)
   ("ee" pyvenv-workon)
   ("ep" poetry)
   ("ev" poetry-venv-workon)
   ("lr" lsp-workspace-restart)
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
   ("SPC" nil)
   ("<ESC>" nil)
   ("<tab>" nil)
   ("C-c" nil)))

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
