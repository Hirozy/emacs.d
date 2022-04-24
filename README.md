# Hiro's emacs.d

This is my personal `emacs.d`, I mainly use it on macOS, but it should also work well with Linux.
This configure is inspired by [purcell's emacs.d](https://github.com/purcell/emacs.d). His configure
is very organized and perfer for the start of a personalized configure. Thanks to purcell.

Recently, I migrated the emacs package manager from `package.el` to [borg](https://github.com/emacscollective/borg).
Borg brings some benefits, such as pining version of a package or rolling back package any time. It also makes it
easy to add packages that are not in `elpa` and `mepla`.

## Installation

To install, clone this repo first, then install all drones (aka packages) with borg.

``` Bash
git clone https://github.com/Hirozy/emacs.d.git ~/.emacs.d
cd ~/.emacs.d
make bootstrap-borg   # bootstrap borg itself
make bootstrap        # bootstrap all drones
```

## TrueColor Support

The solarized-theme does not support `tmux-256color` when used in the terminal.
The detailed discussion is at [Incorrect Colours in Terminal](https://github.com/bbatsov/solarized-emacs/issues/18),
but it is well supported under TrueColor. [Emacs supports TrueColor from 26.1](https://lists.gnu.org/archive/html/emacs-devel/2018-05/msg00765.html).

A more detailed discussion of truecolor here [https://gist.github.com/XVilka/8346728](https://gist.github.com/XVilka/8346728),
first need to determine that the terminal supports TrueColor.

### Enable TrueColor Support

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
