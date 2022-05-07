(when (native-comp-available-p)
  (setq borg-compile-function
        (defun defined/native-compile (filename)
          (and (byte-compile-file filename)
               (native-compile filename)))))

(setq vterm-always-compile-module t)
