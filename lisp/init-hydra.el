(require-packages '(hydra))

(global-set-key
 (kbd "C-S-d")
 (defhydra hydra-edit ()
   "
_;_: comment line    _l_: recent top bottom
_gl_: goto line    _gw_: goto word-1    _gc_: goto char-2
_mf_: format code    _mi_: indent buffer
"
   ("x" delete-char)
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
   ("a" beginning-of-line)
   ("e" move-end-of-line)
   ("i" nil)
   ("o" crux-smart-open-line :exit t)
   ("O" crux-smart-open-line-above :exit t)
   ("v" scroll-up-command)
   ("V" scroll-down-command)
   ("l" recenter-top-bottom :exit t)
   ("gl" avy-goto-line :exit t)
   ("gw" avy-goto-word-1 :exit t)
   ("gc" avy-goto-char-2 :exit t)
   (";" comment-line)
   ("mf" format-all-buffer :exit t)
   ("mi" defined/indent-buffer :exit t)
   ("SPC" nil)))

(global-set-key
 (kbd "C-\"")
 (defhydra hydra-system-function ()
   "
_r_: Reload emacs.d      _eb_: Eval buffer      _er_: Eval region
_kt_: Kill this buffer   _kb_: Kill buffer"
   ("r" defined/reload-init-file :exit t)
   ("eb" eval-buffer :exit t)
   ("er" eval-region :exit t)
   ("kt" kill-this-buffer :exit t)
   ("kb" kill-buffer :exit t)))

(global-set-key
 (kbd "C-'")
 (defhydra hydra-high-frequency ()
   "
_f_: Projectile find file    _p_: Pyvenv workon
"
   ("f" projectile-find-file :exit t)
   ("p" pyvenv-workon :exit t)))

(global-set-key
 (kbd "C-\\")
 (defhydra hydra-window ()
   "
Movement^^        ^Split^           ^Switch^		^Resize^
----------------------------------------------------------------
_h_: ←       	_v_ertical    	_b_uffer		_q_: X←
_j_: ↓        	_x_:horizontal	_f_ind files	_w_: X↓
_k_: ↑        	_z_:undo      	_a_ce 1		_e_: X↑
_l_: →        	_Z_:reset      	_s_wap		_r_: X→
_F_ollow		_D_lt Other   	_S_ave		max_i_mize
_SPC_: cancel	_o_nly this   	_d_elete
"
   ("h" windmove-left )
   ("j" windmove-down )
   ("k" windmove-up )
   ("l" windmove-right )
   ("q" hydra-move-splitter-left)
   ("w" hydra-move-splitter-down)
   ("e" hydra-move-splitter-up)
   ("r" hydra-move-splitter-right)
   ("b" helm-mini)
   ("f" helm-find-files)
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
