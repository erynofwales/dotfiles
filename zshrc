# Eryn Wells <eryn@erynwells.me>

zsh_init_rc_functions=( \
    init_rc_fpath_darwin \
    init-rc-aliases \
    init-rc-ls \
    init-rc-prompt \
    init-rc-zle \
    init-rc-completion \
    init-rc-zsh-options \
    init-rc-zsh-history \
    init-rc-app-environments \
    init-rc-$SYS \
)

if [[ -o LOGIN ]]; then
    zsh_init_rc_functions+=(
        list_tmux_sessions \
    )
fi

do_init_functions zsh_init_rc_functions

autoload -Uz bool
autoload -Uz g
autoload -Uz nethack
autoload -Uz pw
autoload -Uz up
autoload -Uz vi
autoload -Uz homebrew-prefix
