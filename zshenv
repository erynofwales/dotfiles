# .zshenv
# vim: ft=zsh
# Eryn Wells <eryn@erynwells.me>


PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin
[ -d /opt/local/bin ]   && PATH=$PATH:/opt/local/bin
[ -d $HOME/.local/bin ] && PATH=$PATH:$HOME/.local/bin
[ -d $HOME/bin ]        && PATH=$PATH:$HOME/bin

PAGER="less"
MANPAGER=$PAGER
EDITOR="vim"
VISUAL=$EDITOR
LESSHISTFILE="-"
GREP_OPTIONS="--color=auto"
GREP_COLOR="1;32"

export PATH \
       PAGER MANPAGER \
       EDITOR VISUAL \
       LESSHISTFILE \
       GREP_OPTIONS GREP_COLOR

[ `uname -s` = "Linux" ] && export MAIL="/var/mail/$USER"

local py27local=$HOME/.local/lib/python2.7/site-packages
if [[ ! -z $PYTHONPATH ]]; then
    [ -d $py27local ] && PYTHONPATH=$PYTHONPATH:$py27local
else
    PYTHONPATH=$py27local
fi
export PYTHONPATH
