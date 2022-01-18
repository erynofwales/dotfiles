#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

# Start SSH agent for password-less logins
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `ssh-agent -s`
    trap "kill $SSH_AGENT_PID" 0
fi

autoload list_tmux_sessions
list_tmux_sessions

