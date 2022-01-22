#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

ShellLog 'Initializing Login Environment'

# Start SSH agent for password-less logins
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    ShellLog 'Starting ssh-agent'
    eval `ssh-agent -s`
    trap "kill $SSH_AGENT_PID" 0
fi

autoload list_tmux_sessions
list_tmux_sessions

