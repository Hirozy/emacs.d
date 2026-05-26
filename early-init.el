;;; early-init.el --- earliest birds  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; elpa configuration
;;

;;; Code:
(setq load-prefer-newer t)


;; Load local configs
(let ((local-config-el (expand-file-name "local-config.el" user-emacs-directory)))
  (when (file-exists-p local-config-el)
    (load local-config-el)))

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
          ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(when (native-comp-available-p)
  ;; compile .elc files asynchronously
  (setq native-comp-jit-compilation t)

  ;; https://lists.gnu.org/r/bug-gnu-emacs/2023-07/msg01135.html
  ;; `tramp-loaddefs.el' has no-byte-compile: t , so the async compilation does nothing.
  ;; Add `*-loaddefs.el' to the deny list
  (setq native-comp-jit-compilation-deny-list
        (append native-comp-jit-compilation-deny-list
                '("-loaddefs.el"))))

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; early-init.el ends here
