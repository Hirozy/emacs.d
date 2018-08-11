;; (require-packages '())

(setq c-cpp-completion-mode-value "cquery")

(setq c-basic-offset 4)

(defun c-cpp-completion-mode/cquery ()
    (require-packages '(lsp-mode
                        lsp-ui
                        cquery))

    (setq cquery-path (concat dotfiles-dir "site-lisp/package/cquery/build/cquery"))

    (use-package cquery
        :commands lsp-cquery-enable
        :init
        (setq cquery-executable cquery-path)
        (setq cquery-cache-dir "/tmp/")
        (add-hook 'c-mode-hook 'lsp-cquery-enable)
        (add-hook 'c++-mode-hook 'lsp-cquery-enable)
        ;; https://github.com/cquery-project/emacs-cquery/issues/45#issuecomment-406813724
        (add-hook 'lsp-after-open-hook 'lsp-ui-mode)))

(cond ((string= c-cpp-completion-mode-value "cquery")
          (funcall 'c-cpp-completion-mode/cquery)))

(provide 'init-c-cpp)
