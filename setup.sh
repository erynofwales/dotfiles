#!/bin/zsh

dfdir=$(cd "$(dirname "$0")" && pwd)

print -P "%BSymlinking config files%b"
for dotfile in `ls .`
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

    echo -n "  $dest"
    if [[ $action = 'linked' ]]; then
        ln -fs "$dfdir/$dotfile" "$dest"
        action="%F{yellow}$action%f"
    else
        action="%F{green}$action%f"
    fi
    print -P "$spaces%F{green}$action%f"
done

echo "touch $HOME/.hushlogin"
touch "$HOME/.hushlogin"

# Initialize submodules
print -P "%BInitializing git submodules%b"
cd "$dfdir"
git submodule init
git submodule update

exit 0
