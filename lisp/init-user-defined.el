(defun defined/indent-buffer ()
  "Format current buffer"
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun defined/reload-init-file ()
  "Reload Emacs config"
  (interactive)
  (load-file (concat dotfiles-dir "init.el")))

(defun scroll-up-3-lines ()
  "Scroll up 3 lines"
  (interactive)
  (scroll-up 3))

(defun scroll-down-3-lines ()
  "Scroll down 3 lines"
  (interactive)
  (scroll-down 3))

;; http://emacsredux.com/blog/2013/06/15/open-line-above/
(defun defined/smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun defined/file-path ()
  (setq defined/file-name-with-path (buffer-file-name))
  (setq defined/file-name-without-path (file-name-nondirectory
                                        defined/file-name-with-path))
  (setq defined/file-name-without-extension-path (file-name-sans-extension
                                                  defined/file-name-without-path))
  (setq defined/file-path-without-file-name (file-name-directory
                                             defined/file-name-with-path)))

(defun defined/kill-async-shell ()
  (when (get-buffer "*Async Shell Command*")
    (kill-buffer "*Async Shell Command*")))

(defun defined/compile-run-file ()
  (interactive)
  (defined/kill-async-shell)
  (cond
   ((derived-mode-p 'python-mode) (defined/python-file-run-in-shell))
   ((derived-mode-p 'c++-mode) (defined/c-cpp-compile-run))
   ((derived-mode-p 'c-mode) (defined/c-cpp-compile-run))))

(global-set-key (kbd "S-<f10>") 'defined/compile-run-file)

(defun defined/compile-run-file-other-way ()
  (interactive)
  (defined/kill-async-shell)
  (cond
   ((derived-mode-p 'python-mode) (defined/python-file-run))
   ((derived-mode-p 'c++-mode) (defined/c-cpp-cmake-run))
   ((derived-mode-p 'c-mode) (defined/c-cpp-cmake-run))))

(global-set-key (kbd "C-S-<f10>") 'defined/compile-run-file-other-way)

(provide 'init-user-defined)
