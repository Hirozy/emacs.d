;;; init-llm.el --- LLM clients configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; LLM clients configuration
;;

;;; Code:

(require 'transient)

(transient-define-prefix gptel-transient ()
  "GPTel Commands"
  [["Commands"
    ("/" "Send" gptel-send)
    ("s" "Send with prompt" (lambda ()
                              (interactive)
                              (let ((current-prefix-arg '(4))) (call-interactively 'gptel-send))))
    ("a" "Add" gptel-add)
    ("r" "Rewrite" gptel-rewrite)
    ("k" "Abort" gptel-abort)
    ("p" "System Promote" gptel-system-prompt)]

   ["Sessions"
    ("m" "GPTel Menu" gptel-menu)
    ("g" "New Session" gptel)]])

(use-package gptel
  :bind (("C-c g" . gptel-transient)
         :map gptel-mode-map
         ("C-c m" . gptel-menu))
  :config
  (defvar gptel--openrouter
    (gptel-make-openai "OpenRouter"
      :host "openrouter.ai"
      :endpoint "/api/v1/chat/completions"
      :stream t
      :key (gptel-api-key-from-auth-source "openrouter.ai")
      :models '(google/gemini-2.5-flash
                anthropic/claude-sonnet-4.5
                anthropic/claude-opus-4.5
                openai/gpt-4o
                anthropic/claude-haiku-4.5)))

  (setq gptel-backend gptel--openrouter
        ;; Remove the default `ChatGPT' from the `gptel--known-backends'
        gptel--known-backends (delq (assoc "ChatGPT" gptel--known-backends)
                                    gptel--known-backends)))

(provide 'init-llm)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-llm.el ends here
