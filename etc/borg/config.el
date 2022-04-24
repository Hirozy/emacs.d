(when (native-comp-available-p)
  (setq borg-compile-function #'native-compile))

(setq vterm-always-compile-module t)
