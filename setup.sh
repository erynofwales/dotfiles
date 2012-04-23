#!/bin/zsh

dfdir=$(cd "$(dirname "$0")" && pwd)
sys=`uname -s | tr A-Z a-z`

print -P "%BSymlinking config files%b"
for dotfile in `ls $dfdir`
do
    # metafiles; don't link them
    [ $dotfile = 'setup.sh' ] && continue
    [ $dotfile = 'README.md' ] && continue

    local dest="$HOME/.$dotfile"
    local action='skipped'

    if [[ ! -L "$dest" ]]; then
        action='linked'
    else
        action='skipped'
    fi
    filler=$(($COLUMNS - ${#dest} - ${#action} - 4))
    spaces=''
    for (( i=0; $i < $filler; i++ )); do spaces="$spaces " done

    echo -n "  $dest$spaces"
    if [[ $action = 'linked' ]]; then
        ln -fs "$dfdir/$dotfile" "$dest"
        action="%F{yellow}$action%f"
    else
        action="%F{green}$action%f"
    fi
    print -P $action
done

echo "touch $HOME/.hushlogin"
touch "$HOME/.hushlogin"

# Initialize submodules
print -P "%BInitializing git submodules%b"
cd "$dfdir"
git submodule init
git submodule update

exit 0
