;;; early-init.el --- earliest birds  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; elpa configuration
;;

;;; Code:
(setq load-prefer-newer t)

;; WORKAROUND: Add library paths to LIBRARY_PATH to ensure gccemacs can execute properly.
;; NOTE: These paths should be updated whenever gcc in MacPorts is upgraded.
;; LAST VALIDATED: 2026-04-06 with GCC 15.2.0 on macOS 26.4
(when (and (eq system-type 'darwin)
           (native-comp-available-p))
  (setenv "LIBRARY_PATH" (string-join
                          '("/opt/ports/lib/gcc15"
                            "/opt/ports/lib/libgcc"
                            "/opt/ports/lib/gcc15/gcc/aarch64-apple-darwin25/15.2.0")
                          ":")))

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
  ;; Do not compile .elc files asynchronously.
  ;; `inhibit-automatic-native-compilation' and `inhibit-native-compilation'
  ;; appear to be reverted from the Emacs source code
  (setq native-comp-jit-compilation nil)

  ;; WORKAROUND: On MacPorts with nativecomp enabled, tramp-loaddefs.el.gz is recompiled
  ;; at every startup. This package is blacklisted to avoid the overhead.
  (setq native-comp-jit-compilation-deny-list
        (append native-comp-jit-compilation-deny-list
                '("tramp-loaddefs.el.gz"))))

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; early-init.el ends here
