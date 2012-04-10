# .zshenv
# vim: ft=zsh
# Eryn Wells <eryn@erynwells.me>


local sys=`uname -s | tr A-Z a-z`


# Global settings for sh, bash, ksh, zsh derivative shells
[ -e $HOME/.env ] && source $HOME/.env


PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin
[ -d /opt/local/bin ]   && PATH=/opt/local/bin:$PATH
[ -d $HOME/.local/bin ] && PATH=$HOME/.local/bin:$PATH
[ -d $HOME/bin ]        && PATH=$HOME/bin:$PATH


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

[ $sys = 'linux' ] && export MAIL="/var/mail/$USER"


local py27local=$HOME/.local/lib/python2.7/site-packages
if [[ ! -z $PYTHONPATH ]]; then
    [ -d $py27local ] && PYTHONPATH=$py27local:$PYTHONPATH
else
    PYTHONPATH=$py27local
fi
export PYTHONPATH


# System specific environment settings
[ -e $HOME/.zshenv.$sys ] && source $HOME/.zshenv.$sys
# Local environment settings
[ -e $HOME/.zshenv.local ] && source $HOME/.zshenv.local
