# Eryn Wells <eryn@erynwells.me>

# Don't read global startup. It messes things up...
unsetopt GLOBAL_RCS

export SYS=`uname -s | tr A-Z a-z`

function init-env-fpath
{
    local -r fpath_candidates=( \
        "$HOME/.zsh/${SYS}-functions" \
        "$HOME/.zsh/func" \
    )

    # Process the array in reverse order (`Oa` means "descending index order",
    # in other worse "reverse order"; see PARAMETER EXPANSION section of the man
    # pages) so the paths are prepended in the correct order.
    for candidate in ${(Oa)fpath_candidates}; do
        if [[ ! -d "$candidate" ]]; then
            continue
        fi
        fpath=($candidate $fpath)
    done
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
