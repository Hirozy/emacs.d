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
    ("s" "Send" gptel-send)
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
         ("C-c m" . gptel-menu)
         ("C-c C-c" . gptel-send)
         ("C-c C-k" . gptel-abort))
  :config
  (when (eq system-type 'darwin)
    (setq gptel-proxy "http://127.0.0.1:6152"))

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
                                    gptel--known-backends))

  (setf (alist-get 'comment gptel-directives)
        "You are a large language model and a good comment writer. Please rewrite the comments, keep the final line break, and output without any additional text or note.")

  )

(provide 'init-llm)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-llm.el ends here
