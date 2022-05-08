;;; init-completion.el --- Completion configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Completion configuration
;;

;;; Code:

(setq-default indent-tabs-mode nil
              tab-width 4
              tab-always-indent 'complete)

(use-package corfu
  :init
  (setq corfu-auto t
        corfu-auto-prefix 1
        corfu-quit-no-match t
        corfu-quit-at-boundary t
        corfu-separator ?_)
  (global-corfu-mode)

  :hook (((eshell-mode) . (lambda ()
                            (setq-local corfu-auto nil))))

  :bind (:map corfu-map
              ("<backtab>" . corfu-previous)
              ("RET" . corfu-insert)
              ("<return>" . corfu-insert)
              ;; ("SPC" . corfu-insert-separator)
              ("C-n" . corfu-next)
              ("C-p" . corfu-previous)
              ("M-g" . corfu-show-location)
              ("M-h" . corfu-show-documentation)))

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

(use-package corfu-popup
  :unless (display-graphic-p)
  :after corfu
  :config
  (corfu-popup-mode))

(use-package kind-icon
  :defines (kind-icon-margin-formatter)
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package yasnippet
  :diminish yas-minor-mode
  :defer t
  :custom
  (yas-use-menu nil)
  :config
  (setq yas-inhibit-overlay-modification-protection t)
  (advice-add 'yas--on-protection-overlay-modification
              :override #'ignore)
  (yas-global-mode))

(use-package flycheck
  :diminish
  :hook ((prog-mode . flycheck-mode)
         (latex-mode . (lambda ()
                         (flycheck-mode -1))))
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
