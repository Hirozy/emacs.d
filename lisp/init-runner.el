;;; init-runner.el --- Execute current buffer.

;;; Commentary:
;;
;; Execute current buffer.
;;

;;; Require
(require 'package)
(require 'init-packages)

;;; Code:
(require-packages '(quickrun))

(use-package quickrun
  :bind (("<f10>" . quickrun-shell)
         ("S-<f10>" . quickrun)
         ("M-<f10>" . quickrun-compile-only))

  :config
  (quickrun-add-command "c++/g++17"
    '((:command . "g++")
      (:cmdopt . "-std=c++17 -g")
      (:exec . ("%c -x c++ %o -o %e %s" "%e %a"))
      (:compile-only . "%c -Wall -Werror -x c++ %o %o -o %e %s")
      (:remove . ("%e" "%e.dSYM"))
      (:description . "Compile C++ file with g++ and execute")))

  (quickrun-add-command "c++/g++20"
    '((:command . "g++")
      (:cmdopt . "-std=c++20 -g")
      (:exec . ("%c -x c++ %o -o %e %s" "%e %a"))
      (:compile-only . "%c -Wall -Werror -x c++ %o %o -o %e %s")
      (:remove . ("%e" "%e.dSYM"))
      (:description . "Compile C++ file with g++ and execute")))

  (quickrun-add-command "c/gcc11"
    '((:command . "gcc")
      (:cmdopt . "-std=c11 -g")
      (:exec . ("%c -x c %o -o %e %s" "%e %a"))
      (:compile-only . "%c -Wall -Werror %o -o %e %s")
      (:remove . ("%e" "%e.dSYM"))
      (:description . "Compile C file with gcc and execute")))

  (quickrun-add-command "python/python3"
    '((:command . "python3")
      (:exec . ("%c -u %s"))
      (:description . "Run python file with python3")))

  (quickrun-set-default "c++" "c++/g++17")
  (quickrun-set-default "c" "c/gcc11")
  (quickrun-set-default "python" "python/python3"))

(provide 'init-runner)

;;; init-runner.el ends here
