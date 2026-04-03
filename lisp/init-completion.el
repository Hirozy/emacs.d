;;; init-completion.el --- Completion configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Completion configuration
;;

;;; Code:

(setq-default indent-tabs-mode nil
              tab-width 4
              tab-always-indent 'complete)

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.05)
  (corfu-auto-prefix 2)
  :init
  (global-corfu-mode)
  :hook (((eshell-mode) . (lambda ()
                            (setq-local corfu-auto nil))))
  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ("S-TAB" . corfu-previous)
              ([tab] . corfu-next)
              ([backtab] . corfu-previous)
              ("RET" . corfu-insert)
              ([return] . corfu-insert)
              ("&" . corfu-insert-separator)
              ("M-g" . corfu-info-location)
              ("M-h" . corfu-info-documentation)))

(defalias 'defined/cape-dabbrev-min (cape-capf-prefix-length #'cape-dabbrev 3))

(use-package cape
  :hook ((prog-mode . (lambda ()
                        (setq-local completion-at-point-functions
                                    (list #'tempel-expand
                                          #'defined/cape-dabbrev-min))))
         (text-mode . (lambda ()
                        (setq-local completion-at-point-functions
                                    (list #'tempel-expand
                                          #'cape-file
                                          #'defined/cape-dabbrev-min))))
         ((org-mode markdown-mode) . (lambda ()
                                       (setq-local completion-at-point-functions
                                                   (list #'tempel-expand
                                                         #'cape-file
                                                         #'cape-tex
                                                         #'defined/cape-dabbrev-min
                                                         #'cape-elisp-block))))
         (cmake-mode . (lambda ()
                         (setq-local completion-at-point-functions
                                     (list
                                      (cape-company-to-capf #'company-cmake)))))
         ((emacs-lisp-mode lisp-data-mode) . (lambda ()
                                               (setq-local completion-at-point-functions
                                                           (list #'tempel-expand
                                                                 #'cape-file
                                                                 #'elisp-completion-at-point
                                                                 #'defined/cape-dabbrev-min)))))
  :custom
  ;; Never set the `corfu-quit-no-match' to `t' as this will cause
  ;; completion to exit automatically when an error character is entered.
  (corfu-quit-no-match 'separator)
  (corfu-quit-at-boundary 'separator)
  :config
  (advice-add 'dabbrev-capf :around #'cape-wrap-silent))

(use-package corfu-terminal
  :unless (display-graphic-p)
  :after corfu
  :config
  (corfu-terminal-mode))

(use-package tempel
  :defer t
  :bind (:map tempel-map
              ("M-n" . tempel-next)
              ("M-p" . tempel-previous))
  :custom
  (tempel-trigger-prefix ";"))

(use-package flycheck
  :diminish
  :defer t
  :custom
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-keymap-prefix (kbd "C-c C-l")))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :hook ((
          c-mode c++-mode objc-mode c-ts-mode c++-ts-mode
          python-mode python-ts-mode
          haskell-mode haskell-literate-mode
          go-mode go-ts-mode
          rust-mode rust-ts-mode
          ) . flycheck-eglot-mode))

(use-package flymake
  :defer t
  :diminish flymake-mode)

(provide 'init-completion)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-completion.el ends here
