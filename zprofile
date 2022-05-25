#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

zsh_init_profile_functions=( \
    connect_ssh_agent \
    init_profile_$SYS \
    list_tmux_sessions \
)

do_init_functions zsh_init_profile_functions

