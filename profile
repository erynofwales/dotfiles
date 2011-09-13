# .profile
# vim: ft=zsh
# Eryn Wells <eryn@erynwells.me>

# Gotta do some machine specific setup
arch=`uname -s`
case $arch in
    Linux)
        alias iptls='sudo iptables --line-numbers -nv -L'
        alias ip6tls='sudo ip6tables --line-numbers -nv -L'
        alias rlx="xrdb $HOME/.Xdefaults"
    ;;

    Darwin)
	alias indent='gnuindent'
	alias acls='/bin/ls -le'
    ;;
esac

# NetHack options
# use color in the terminal
export NETHACKOPTIONS="color"

[ -e $HOME/.profile-local ] && source $HOME/.profile-local

# Start SSH agent for password-less logins
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]
then
    eval `ssh-agent -s`
    trap "kill $SSH_AGENT_PID" 0
fi

LEDGER_FILE=$HOME/Documents/Financial/personal.ledger
export LEDGER_FILE PATH
