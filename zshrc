#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

zsh_init_rc_functions=( \
    init_rc_aliases \
    init_configure_ls \
    init_rc_tilde_paths \
    init_rc_configure_prompt \
    init_rc_configure_zle \
    init_rc_configure_completion \
    init_zsh_options \
    init_zsh_history \
    init_app_environments \
    init_rc_$SYS \
)

do_init_functions zsh_init_rc_functions

autoload -Uz g
autoload -Uz nethack
autoload -Uz pw
autoload -Uz up
autoload -Uz vi
autoload -Uz open-xcode
