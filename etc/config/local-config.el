(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|127\\.*\\)")
        ("http" . "127.0.0.1:6152")
        ("https" . "127.0.0.1:6152")
        ("ftp" . "127.0.0.1:6152")))

;; WORKAROUND: Add library paths to LIBRARY_PATH to ensure gccemacs can execute properly.
;; NOTE: These paths should be updated whenever gcc in MacPorts is upgraded.
;; LAST VALIDATED: 2026-04-06 with GCC 15.2.0 on macOS 26.4
(when (native-comp-available-p)
  (setenv "LIBRARY_PATH" (string-join
                          '("/opt/local/lib/gcc15"
                            "/opt/local/lib/libgcc"
                            "/opt/local/lib/gcc15/gcc/aarch64-apple-darwin25/15.2.0")
                          ":")))
