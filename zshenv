# .zshenv
# vim: ft=zsh
#
# Environment settings for zsh
#
# Eryn Wells <eryn@erynwells.me>

[ -e $HOME/.env ] && source $HOME/.env

# System specific environment settings
[ -e $HOME/.zshenv.$SYS ] && source $HOME/.zshenv.$SYS
# Local environment settings
[ -e $HOME/.zshenv.local ] && source $HOME/.zshenv.local
