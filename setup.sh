#!/usr/bin/env zsh

dfdir=$(cd "$(dirname "$0")" && pwd)
sys=`uname -s | tr A-Z a-z`

skipitems=(setup.sh README.md py bin Colors)

typeset -A vimbundles
vimbundles=(Vundle.vim  "https://github.com/gmarik/Vundle.vim.git")


function link
{
    local dest
    if [[ "$2" == '' ]]; then
        dest="$HOME/.$dotfile"
    else
        dest="$2"
    fi

    if [[ ! -e "$dest" ]]; then
        action='Linking'
        ln -fs "$1" "$dest"
    else
        action='Skipping'
    fi
    printf "  %8s: %s\n" $action $dest
}


print -P "%BSymlinking config files%b"
for dotfile in `ls $dfdir`; do
    [[ ${skipitems[(r)$dotfile]} == $dotfile ]] && continue
    link "$dfdir/$dotfile"
done

link "$dfdir/bin" "$HOME/bin"

echo "touch $HOME/.hushlogin"
touch "$HOME/.hushlogin"

# Initialize submodules
print -P "%BFetching Vim modules%b"
cd "$dfdir/vim/bundle"
for module in ${(k)vimbundles}; do
    echo -n "  $module"

    if [[ -d $module ]]; then
    # result='skipped'
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

if [[ -d "$dfdir/vim/bundle/command-t/ruby/command-t" ]]; then
    print -P "%BSetting up command-t%b"
    cd "$dfdir/vim/bundle/command-t/ruby/command-t"
    ruby extconf.rb
    make
fi

exit 0
