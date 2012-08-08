#!/bin/zsh

dfdir=$(cd "$(dirname "$0")" && pwd)
sys=`uname -s | tr A-Z a-z`

# Vim bundles
typeset -A vimbundles
vimbundles=( \
    blackboard "https://github.com/nelstrom/vim-blackboard.git" \
    command-t "https://github.com/wincent/Command-T.git" \
    fugitive "https://github.com/tpope/vim-fugitive.git" \
    gundo "https://github.com/sjl/gundo.vim.git" \
    repeat "https://github.com/tpope/vim-repeat" \
    snipmate "https://github.com/msanders/snipmate.vim.git" \
    solarized "https://github.com/altercation/vim-colors-solarized.git" \
    speeddating "https://github.com/tpope/vim-speeddating.git" \
    surround "https://github.com/tpope/vim-surround.git" \
    unimpaired "https://github.com/tpope/vim-unimpaired.git" \
)

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
    for (( i=0; $i < $filler; i++ )); do spaces="$spaces "; done

    echo -n "  $dest"
    if [[ $action == 'linked' ]]; then
        ln -fs "$dfdir/$dotfile" "$dest"
        action="%F{green}$action%f"
    elif [[ $action == 'skipped' ]]; then
        action="%F{yellow}$action%f"
    else
        action="%F{red}red%f"
    fi
    print -P "$spaces$action"
done

echo "touch $HOME/.hushlogin"
touch "$HOME/.hushlogin"

# Initialize submodules
print -P "%BFetching Vim modules%b"
cd "$dfdir/vim/bundle"
for module in ${(k)vimbundles}; do
    echo -n "  $module"

    if [ -d $module ]; then
        result='skipped'
    else
        git clone ${vimbundles[$module]} $module 1>/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            result='done'
        else
            result='failed'
        fi
    fi

    spaces=''
    filler=$(($COLUMNS - ${#module} - ${#result} - 4))
    for (( i=0; $i < $filler; i++ )); do spaces="$spaces "; done
    if [[ $result == 'skipped' ]]; then
        color='yellow'
    elif [[ $result == 'failed' ]]; then
        color='red'
    elif [[ $result == 'done' ]]; then
        color='green'
    fi
    print -P "$spaces%F{$color}$result%f"
done

exit 0
