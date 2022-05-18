EMACS_EXTRA += --eval "(setq native-comp-async-jobs-number (max 1 (- (num-processors) 2)))"
EMACS_EXTRA += --eval "(setq native-comp-always-compile t)"
