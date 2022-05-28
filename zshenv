# .zshenv
# vim: ft=zsh
# Eryn Wells <eryn@erynwells.me>

# Don't read global startup. It messes things up...
unsetopt GLOBAL_RCS

export SYS=`uname -s | tr A-Z a-z`

fpath=("$HOME/.zsh/func" $fpath)

autoload -Uz do_init_functions

typeset -a zsh_init_env_functions=( \
    init_path \
    init_env \
    init_env_python \
    init_env_vi \
    init_env_$SYS \
)

do_init_functions zsh_init_env_functions

if [[ -e "$HOME/.zshenv.local" ]]; then
    source "$HOME/.zshenv.local"
fi
