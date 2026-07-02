;;; init-markdown.el --- markdown mode configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; markdown mode configuration
;;

;;; Code:

(use-package markdown-mode
  :defer t
  :hook ((markdown-mode gfm-mode) . valign-mode)
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "marked")
  (markdown-css-paths
   '("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.9.0/github-markdown-light.min.css"))
  (markdown-xhtml-header-content
   (concat "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>"
           "<style> body.markdown-body { box-sizing: border-box; max-width: 1080px; width: 100%; margin: 40px auto; padding: 0 10px; } </style>"
           ;; highlight.js: theme CSS (colors) + script.
           "<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github.min.css'>"
           "<script src='https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js'></script>"
           ;; MathJax — enable $...$ inline math (off by default in v3,
           ;; which only enables $$...$$, \(...\), \[...\]).
           "<script>window.MathJax = { tex: { inlineMath: [['\\\\(','\\\\)'], ['$','$']] } };</script>"
           "<script id='MathJax-script' async src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/es5/tex-mml-chtml.js'></script>"
           ;; Mermaid diagrams.
           "<script src='https://cdnjs.cloudflare.com/ajax/libs/mermaid/11.12.0/mermaid.min.js'></script>"
           "<script>"
           "document.addEventListener('DOMContentLoaded', () => {"
           "  document.body.classList.add('markdown-body');"
           "  /* marked emits <pre><code class='language-mermaid'> for fenced"
           "     ```mermaid blocks, but mermaid v10+ only detects elements"
           "     with class 'mermaid'.  Rewrite them BEFORE hljs runs. */"
           "  document.querySelectorAll('pre > code.language-mermaid, pre > code.lang-mermaid')"
           "    .forEach((code) => {"
           "      const div = document.createElement('div');"
           "      div.className = 'mermaid';"
           "      div.textContent = code.textContent;"
           "      code.parentElement.replaceWith(div);"
           "    });"
           "  /* PlantUML: render via a PlantUML server.  Encode the source as"
           "     UTF-8 hex and request an SVG (~h prefix = hex, no compression)."
           "     Replace the <pre> BEFORE hljs runs.  To use a local server,"
           "     change PLANTUML_URL below. */"
           "  const PLANTUML_URL = 'https://www.plantuml.com/plantuml/svg/~h';"
           "  document.querySelectorAll('pre > code.language-plantuml, pre > code.lang-plantuml')"
           "    .forEach((code) => {"
           "      const hex = Array.from(new TextEncoder().encode(code.textContent),"
           "                             b => b.toString(16).padStart(2, '0')).join('');"
           "      const img = document.createElement('img');"
           "      img.src = PLANTUML_URL + hex;"
           "      img.alt = 'PlantUML diagram';"
           "      img.style.maxWidth = '100%';"
           "      code.parentElement.replaceWith(img);"
           "    });"
           "  document.querySelectorAll('pre > code').forEach((code) => { hljs.highlightElement(code); });"
           "  if (window.mermaid) { mermaid.initialize({ startOnLoad: false }); mermaid.run(); }"
           "});"
           "</script>")))

(provide 'init-markdown)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-markdown.el ends here
