;; -*- lexical-binding: t; -*-
(when (native-comp-available-p)
  (setq package-native-compile t))

(when (require 'evil-collection nil t)
  (setq evil-want-integration t
        evil-want-keybinding nil))
