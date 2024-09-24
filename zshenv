# Eryn Wells <eryn@erynwells.me>

# Don't read global startup. It messes things up...
unsetopt GLOBAL_RCS

export SYS=`uname -s | tr A-Z a-z`

function init-env-fpath
{
    local user_fpath=("$HOME/.zsh/func")

    local sys_fpath="$HOME/.zsh/func/$SYS"
    if [[ -d "$sys_fpath" ]]; then
        user_fpath+=($sys_fpath)
    fi

    fpath=($user_fpath $fpath)
    export FPATH
}

init-env-fpath

autoload -Uz do_init_functions

typeset -a zsh_init_env_functions=( \
    init-path \
    init-unix-env \
    init-zsh-helpers \
    init_env_python \
    init_env_playdate \
    init-vi \
    init_env_$SYS \
)

do_init_functions zsh_init_env_functions
