#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

autoload -Uz init_app_environments
autoload -Uz init_configure_ls
autoload -Uz init_rc_aliases
autoload -Uz init_rc_configure_completion
autoload -Uz init_rc_configure_prompt
autoload -Uz init_rc_configure_zle
autoload -Uz init_zsh_options
autoload -Uz init_zsh_history
autoload -Uz init_zsh_functions

init_rc_aliases
init_rc_configure_prompt loquacious
init_rc_configure_zle emacs
init_rc_configure_completion
init_zsh_options
init_zsh_history
init_app_environments

autoload +X init_rc_$SYS
init_rc_$SYS

# Configure ls with the system ls if it hasn't been done already.
if ! alias ls 2>&1 1>/dev/null; then
    init_configure_ls `which ls`
fi

autoload -Uz g
autoload -Uz nethack
autoload -Uz pw
autoload -Uz up
autoload -Uz vi
