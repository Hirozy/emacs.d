;;; init-completion.el --- Completion configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Completion configuration
;;

;;; Code:

(setq-default indent-tabs-mode nil
              tab-width 4
              tab-always-indent 'complete)

(defvar capf-based-list  '(tempel-expand
                           cape-file))

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
              ("," . corfu-insert-separator)
              ("M-g" . corfu-info-location)
              ("M-h" . corfu-info-documentation)))

(use-package cape
  :hook ((prog-mode . (lambda ()
                        (setq-local completion-at-point-functions
                                    `(,@capf-based-list
                                      cape-dabbrev))))
         (text-mode . (lambda ()
                        (setq-local completion-at-point-functions
                                    `(,@capf-based-list
                                      cape-dabbrev
                                      cape-tex
                                      cape-dict))))
         ((org-mode markdown-mode) . (lambda ()
                                       (add-to-list 'completion-at-point-functions #'cape-elisp-block)))
         (cmake-mode . (lambda ()
                         (setq-local completion-at-point-functions
                                     `(,@capf-based-list
                                       ,(cape-company-to-capf #'company-cmake)))))
         (emacs-lisp-mode . (lambda ()
                              (setq-local completion-at-point-functions
                                          `(,@capf-based-list
                                            ,(cape-capf-nonexclusive #'elisp-completion-at-point)
                                            cape-dabbrev)))))
  :config
  (setq cape-dabbrev-min-length 6))

(use-package corfu-terminal
  :unless (display-graphic-p)
  :after corfu
  :config
  (corfu-terminal-mode))

(use-package tempel
  :defer t
  :custom
  (tempel-trigger-prefix "<"))

(use-package flycheck
  :diminish
  :defer t
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c C-l"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :hook ((c-mode
          c++-mode
          objc-mode
          python-mode
          haskell-mode
          haskell-literate-mode
          go-mode
          rustic-mode) . flycheck-eglot-mode))

(use-package flymake
  :defer t
  :diminish flymake-mode)

(provide 'init-completion)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-completion.el ends here
