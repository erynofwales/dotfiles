#!/bin/bash

dfdir=$(cd "$(dirname "$0")" && pwd)

ln -s "$dfdir/profile" "$HOME/.profile"
ln -s "$dfdir/rc" "$HOME/.rc"

ln -s "$dfdir/zshrc" "$HOME/.zshrc"
ln -s "$dfdir/zsh" "$HOME/.zsh"
ln -s "$dfdir/zprofile" "$HOME/.zprofile"
ln -s "$dfdir/zshenv" "$HOME/.zshenv"

ln -s "$dfdir/vimrc" "$HOME/.vimrc"
ln -s "$dfdir/vim" "$HOME/.vim"

ln -s "$dfdir/indent.pro" "$HOME/.indent.pro"
ln -s "$dfdir/screenrc" "$HOME/.screenrc"
ln -s "$dfdir/tmux.conf" "$HOME/.tmux.conf"
ln -s "$dfdir/ledgerrc" "$HOME/.ledgerrc"
ln -s "$dfdir/toprc" "$HOME/.toprc"

ln -s "$dfdir/gitconfig" "$HOME/.gitconfig"

ln -s "$dfdir/irssi" "$HOME/.irssi"

[ `uname -s` = "Linux" ] && ln -s "$dfdir/Xdefaults" "$HOME/.Xdefaults"

touch "$HOME/.hushlogin"

# Initialized submodules
cd "$dfdir"
git submodule init
git submodule update

exit 0
