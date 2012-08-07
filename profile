# .profile
# vim: ft=zsh
# Eryn Wells <eryn@erynwells.me>

# Start SSH agent for password-less logins
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    print_info_noisy 1 'Starting ssh-agent'
    eval `ssh-agent -s`
    trap "kill $SSH_AGENT_PID" 0
fi
