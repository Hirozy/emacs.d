;;; init-llm.el --- LLM clients configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; LLM clients configuration
;;

;;; Code:

(require 'init-defun)

(let ((llm-secret-el (expand-file-name "llm-config.el" user-emacs-directory)))
  (when (file-exists-p llm-secret-el)
    (load llm-secret-el)))

(use-package gptel
  :defer t
  :bind (:map gptel-mode-map
              ("C-c m" . gptel-menu)
              ("C-c C-c" . gptel-send)
              ("C-c C-k" . gptel-abort))
  :config
  (defvar gptel--openrouter
    (gptel-make-openai "OpenRouter"
      :host "openrouter.ai"
      :endpoint "/api/v1/chat/completions"
      :stream t
      :key (defined/get-auth-password "openrouter.ai")
      :models '(google/gemini-2.5-flash
                anthropic/claude-sonnet-4.5
                anthropic/claude-opus-4.5
                openai/gpt-4o
                anthropic/claude-haiku-4.5)))

  (setq gptel-backend gptel--openrouter
        ;; Remove the default `ChatGPT' from the `gptel--known-backends'
        gptel--known-backends (delq (assoc "ChatGPT" gptel--known-backends)
                                    gptel--known-backends))

  (setq gptel-model 'anthropic/claude-haiku-4.5)

  (setf (alist-get 'comment gptel-directives)
        "You are a large language model and a good comment writer. Please rewrite the comments, keep the final line break, and output without any additional text or note.")
  )

(defvar defined/agent-shell--wrapped-commands
  '(agent-shell-next-item
    agent-shell-previous-item
    agent-shell-previous-input
    agent-shell-next-input
    agent-shell-cycle-session-mode
    agent-shell-set-session-mode
    agent-shell-set-session-model
    agent-shell-interrupt
    agent-shell-clear-buffer
    agent-shell-fork
    agent-shell-insert-shell-command-output)
  "List of agent-shell commands that have wrapper functions.
These wrappers switch to agent-shell buffer before executing the command.")

(dolist (cmd defined/agent-shell--wrapped-commands)
  (eval `(defined/agent-shell-commands-with-judge-wrapper ,cmd)))

(use-package agent-shell
  :defer t
  :custom
  (agent-shell-header-style 'text)
  (agent-shell-show-config-icons nil)
  (agent-shell-display-action
   '(display-buffer-in-side-window (side . right) (window-width . 0.4)))
  :config
  (evil-make-intercept-map agent-shell-mode-map 'normal)
  (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
  (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input)

  ;; Fix UTF-8 encoding for history read
  ;; `shell-maker--write-input-ring-history' has no issue
  (advice-add 'shell-maker--read-input-ring-history :around
    (lambda (orig-fun config)
      "Read history with UTF-8 encoding."
      (let ((path (shell-maker-history-file-path config))
            (ring))
        (make-directory (file-name-directory path) t)
        (setq-local comint-input-ring-file-name nil)
        (setq-local comint-input-ignoredups t)
        (setq ring (ignore-errors
                     (with-temp-buffer
                       (setq-local coding-system-for-read 'utf-8)
                       (insert-file-contents path)
                       (read (current-buffer)))))
        (unless (ring-p ring)
          (setq ring (make-ring (min 1500 comint-input-ring-size))))
        (setq comint-input-ring ring)))
    '((name . .utf8-read-fix)))

  (add-hook 'diff-mode-hook
            (lambda ()
              (when (string-match-p "\\*agent-shell-diff\\*" (buffer-name))
                (evil-emacs-state)))))

(provide 'init-llm)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-llm.el ends here
