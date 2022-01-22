# .zshenv
# vim: ft=zsh
# Eryn Wells <eryn@erynwells.me>

# Don't read global startup. It messes things up...
unsetopt GLOBAL_RCS

export SYS=`uname -s | tr A-Z a-z`

fpath=("$HOME/.zsh/func" $fpath)
autoload +X prepend_to_path
autoload +X append_to_path
autoload +X init_env
autoload +X init_env_python
autoload +X init_path

init_path
init_env
init_env_python

if autoload +X init_env_$SYS; then
    init_env_$SYS
fi
