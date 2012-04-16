# .zshenv
# vim: ft=zsh
#
# Environment settings for zsh
#
# Eryn Wells <eryn@erynwells.me>

[ -e $HOME/.env ] && source $HOME/.env

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

[ $SYS = 'linux' ] && export MAIL="/var/mail/$USER"

local py27local=$HOME/.local/lib/python2.7/site-packages
if [[ ! -z $PYTHONPATH ]]; then
    [ -d $py27local ] && PYTHONPATH=$py27local:$PYTHONPATH
else
    PYTHONPATH=$py27local
fi
export PYTHONPATH

# System specific environment settings
[ -e $HOME/.zshenv.$SYS ] && source $HOME/.zshenv.$SYS
# Local environment settings
[ -e $HOME/.zshenv.local ] && source $HOME/.zshenv.local
