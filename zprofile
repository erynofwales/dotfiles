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

autoload list_tmux_sessions
list_tmux_sessions

