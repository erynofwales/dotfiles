#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

# Start SSH agent for password-less logins
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    if ! pgrep -u $USER ssh-agent 1>/dev/null; then
        eval $(ssh-agent -s > ~/.ssh_agent_vars)
        trap "kill $SSH_AGENT_PID" 0
    else
        eval $(cat ~/.ssh_agent_vars)
    fi
fi

autoload -Uz list_tmux_sessions
autoload -Uz binary_exists

if binary_exists sw_vers && binary_exists lolcat; then
    case $SYS in
        darwin)
            print "It's `date +'%H:%M on %A, %B %d'`.\nThis machine is a $HWMODEL.\nYou're running macOS $OSVERSION.\n" | lolcat
            ;;
        *) ;;
    esac
fi

list_tmux_sessions
