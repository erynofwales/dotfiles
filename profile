# .profile
# vim: ft=zsh
# Eryn Wells <eryn@3b518c.com>

# Environment settings
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin
PAGER="less"
MANPAGER="less"
EDITOR="vim"
VISUAL=$EDITOR
LESSHISTFILE="-"
GREP_OPTIONS="--color=auto"
GREP_COLOR="1;32"
export PAGER MANPAGER EDITOR VISUAL LESSHISTFILE GREP_OPTIONS GREP_COLOR

# Gotta do some machine specific setup
arch=`uname -s`
case $arch in
    Linux)
        export MAIL="/var/mail/$USER"
        alias iptls='sudo iptables --line-numbers -nv -L'
        alias ip6tls='sudo ip6tables --line-numbers -nv -L'
        alias rlx="xrdb $HOME/.Xdefaults"
    ;;

    Darwin)
	alias indent='gnuindent'
    ;;
esac

# NetHack options
# use color in the terminal
export NETHACKOPTIONS="color"

[ -e $HOME/.profile-local ] && source $HOME/.profile-local
[ -d $HOME/.local/bin ] && PATH=$HOME/.local/bin:$PATH
[ -d $HOME/bin ] && PATH=$HOME/bin:$PATH

# Start SSH agent for password-less logins
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]
then
    eval `ssh-agent -s`
    trap "kill $SSH_AGENT_PID" 0
fi

LEDGER_FILE=$HOME/Documents/Financial/personal.ledger
export LEDGER_FILE PATH
