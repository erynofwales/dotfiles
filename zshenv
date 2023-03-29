# Eryn Wells <eryn@erynwells.me>

# Don't read global startup. It messes things up...
unsetopt GLOBAL_RCS

export SYS=`uname -s | tr A-Z a-z`

init_env_fpath() {
    local user_fpath=("$HOME/.zsh/func")

    if [[ "$SYS" == "darwin" ]]; then
        user_fpath=($user_fpath "$HOME/.zsh/func/darwin")
    fi

    fpath=($user_fpath $fpath)
    export FPATH
}

init_env_fpath

autoload -Uz do_init_functions

typeset -a zsh_init_env_functions=( \
    init_path \
    init_env \
    init_env_aliases \
    init_env_python \
    init_env_playdate \
    init_env_vi \
    init_env_$SYS \
)

do_init_functions zsh_init_env_functions
