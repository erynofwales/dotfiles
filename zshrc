#!/usr/bin/env zsh
# Eryn Wells <eryn@erynwells.me>

shell-log 'Initializing Interactive Environment'

autoload init_app_environments
autoload init_rc_aliases
autoload init_rc_configure_completion
autoload init_rc_configure_ls
autoload init_rc_configure_prompt
autoload init_rc_configure_zle
autoload init_zsh_options
autoload init_zsh_history
autoload init_zsh_functions

init_rc_aliases
init_rc_configure_prompt loquacious
init_rc_configure_zle emacs
init_rc_configure_completion
init_zsh_options
init_zsh_history
init_zsh_functions
init_app_environments

autoload +X init_rc_$SYS
init_rc_$SYS

# Configure ls with the system ls if it hasn't been done already.
if ! alias ls 2>&1 1>/dev/null; then
    init_rc_configure_ls `which ls`
fi

autoload g
autoload vi
