## My personal emacs.d

This is my own emacs.d, I only use it on macOS and Linux.

### Install

``` Bash
git clone https://github.com/Hirozy/emacs.d.git ~/.emacs.d
```

When you start emacs for the first time, it automatically installs all packages through the Emacs Lisp Package Archive.

### TrueColor Support

The solarized-theme does not support `tmux-256color` when used in the terminal. The detailed discussion is at [Incorrect Colours in Terminal](https://github.com/bbatsov/solarized-emacs/issues/18) , but it is well supported under TrueColor. [Emacs supports TrueColor from 26.1](https://lists.gnu.org/archive/html/emacs-devel/2018-05/msg00765.html).

A more detailed discussion of truecolor here [https://gist.github.com/XVilka/8346728](https://gist.github.com/XVilka/8346728) , first need to determine that the terminal supports TrueColor.

#### Enable TrueColor Support

``` Bash
cat > terminfo-24bit.src << \EOF
# Use semicolon separators.
xterm-24bits|xterm with 24-bit direct color mode,
    use=xterm-256color,
    setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
    setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF
    
tic -x -o ~/.terminfo terminfo-24bit.src
```

If you are using a Bash/Zsh shell
``` Bash
TERM=xterm-24bits emacs -nw
```

If you are using a fish shell
``` Bash
env TERM=xterm-24bits emacs -nw
```
