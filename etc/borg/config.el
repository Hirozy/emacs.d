(when (native-comp-available-p)
  (setq package-native-compile t))

(when (and (memq window-system '(mac ns x)) (require 'vterm nil t))
  (setq vterm-always-compile-module t))

(when (require 'evil-collection nil t)
  (setq evil-want-integration t
        evil-want-keybinding nil))
