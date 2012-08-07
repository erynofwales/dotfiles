# .zprofile
# vim:ft=zsh
#
# Login shell setup
#
# Eryn Wells <eryn@erynwells.me>

print_info_noisy 1 'Initializing login shell'

[ -e $HOME/.profile ] && source $HOME/.profile

# Any ZSH stuff goes here.

[ -e $HOME/.profile.$SYS ] && source $HOME/.profile.$SYS
[ -e $HOME/.profile.local ] && source $HOME/.profile.local
