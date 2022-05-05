;;; early-init.el --- earliest birds -*- lexical-binding: t -*-

;;; Commentary:
;;
;; elpa configuration
;;

;;; Code:
(setq load-prefer-newer t)

(let ((dotfiles-dir (file-name-directory (or load-file-name buffer-file-name))))
  (add-to-list 'load-path (expand-file-name "lib/packed" dotfiles-dir))
  (add-to-list 'load-path (expand-file-name "lib/compat" dotfiles-dir))
  (add-to-list 'load-path (expand-file-name "lib/auto-compile" dotfiles-dir))
  (add-to-list 'load-path (expand-file-name "lisp" dotfiles-dir)))

(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(setq package-enable-at-startup nil)

(with-eval-after-load 'package
                      (setq package-archives
                            '(("gnu" . "https://elpa.gnu.org/packages/")
                              ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                              ("melpa" . "https://melpa.org/packages/"))))

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; early-init.el ends here
