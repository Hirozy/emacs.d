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
  (corfu-separator ?\s)
  (corfu-auto-delay 0.05)
  (corfu-auto-prefix 2)
  (corfu-preselect 'first)
  (corfu-quit-no-match t)
  :init
  (global-corfu-mode)

  :hook (((eshell-mode) . (lambda ()
                            (setq-local corfu-auto nil))))

  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous)
              ("RET" . corfu-complete)
              ("<return>" . corfu-complete)
              ("SPC" . corfu-insert-separator)
              ("C-n" . corfu-next)
              ("C-p" . corfu-previous)))

(use-package cape
  :bind (("M-<tab> f" . cape-file)
         ("M-<tab> d" . cape-dabbrev))
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package company-cmake
  :hook (cmake-mode . (lambda ()
                        (setq-local completion-at-point-functions
                                    (list (cape-company-to-capf #'company-cmake)
                                          #'cape-file
                                          #'cape-dabbrev)))))

(use-package corfu-terminal
  :unless (display-graphic-p)
  :after corfu
  :config
  (corfu-terminal-mode))

(use-package kind-all-the-icons
  :when (display-graphic-p)
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters
               #'kind-all-the-icons-margin-formatter))

(use-package tempel
  :custom
  (tempel-trigger-prefix "<"))

(use-package flycheck
  :diminish
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c C-l"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map))

(use-package flymake
  :defer t
  :diminish flymake-mode)

(provide 'init-completion)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-completion.el ends here
