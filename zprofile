# .zprofile
# vim:ft=zsh
#
# Login shell setup
#
# Eryn Wells <eryn@erynwells.me>

[ -e $HOME/.profile ] && source $HOME/.profile

# Any ZSH stuff goes here.

[ -e $HOME/.profile.$SYS ] && source $HOME/.profile.$SYS
[ -e $HOME/.profile.local ] && source $HOME/.profile.local
