# Eryn Wells <eryn@erynwells.me>

# Don't read global startup. It messes things up...
unsetopt GLOBAL_RCS

export SYS=`uname -s | tr A-Z a-z`

init_env_fpath() {
    local USER_FPATH=( "$HOME/.zsh/func" )

    if [[ "$SYS" == "darwin" ]]; then
        USER_FPATH=($USER_FPATH "$HOME/.zsh/func/darwin")
    fi

    fpath=($USER_FPATH $fpath)
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
