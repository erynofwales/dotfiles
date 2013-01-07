# .zprofile
# vim:ft=zsh
#
# Login shell setup
#
# Eryn Wells <eryn@erynwells.me>

print_heading -l 1 'Initializing login shell'

[ -e $HOME/.profile ] && source $HOME/.profile

list_tmux_sessions()
{
    tmux_out=`tmux list-sessions 2>/dev/null`
    [[ -z "$tmux_out" ]] && return

    echo "You have the following active tmux sessions:"
    for session in ${(f)tmux_out}; do
        echo "    $session"
    done
    echo
}

list_tmux_sessions

[ -e $HOME/.profile.$SYS ] && source $HOME/.profile.$SYS
[ -e $HOME/.profile.local ] && source $HOME/.profile.local
