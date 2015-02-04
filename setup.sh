#!/usr/bin/env zsh

dfdir=$(cd "$(dirname "$0")" && pwd)
sys=`uname -s | tr A-Z a-z`

omzrepo=git://github.com/robbyrussell/oh-my-zsh.git

# Vim bundles
typeset -A vimbundles

# Commented out Vim plugin repos, 'cause I'm not using them...
#    blackboard "https://github.com/nelstrom/vim-blackboard.git" \
#    fugitive "https://github.com/tpope/vim-fugitive.git" \
#    command-t           "https://github.com/wincent/Command-T.git" \
#
#    dash                "https://github.com/rizzatti/dash.vim.git"
#    funcoo              "https://github.com/rizzatti/funcoo.vim.git" \
#    gundo               "https://github.com/sjl/gundo.vim.git" \
#    mw-utils            "https://github.com/MarcWeber/vim-addon-mw-utils.git" \
#    repeat              "https://github.com/tpope/vim-repeat" \
#    snipmate            "https://github.com/garbas/vim-snipmate.git" \
#    snipmate-snippets   "https://github.com/honza/vim-snippets.git" \
#    snipmate-zope       "https://github.com/zedr/zope-snipmate-bundle.git" \
#    solarized           "https://github.com/altercation/vim-colors-solarized.git" \
#    speeddating         "https://github.com/tpope/vim-speeddating.git" \
#    surround            "https://github.com/tpope/vim-surround.git" \
#    tlib                "https://github.com/tomtom/tlib_vim.git" \
#    unimpaired          "https://github.com/tpope/vim-unimpaired.git" \
vimbundles=( \
    Vundle.vim          "https://github.com/gmarik/Vundle.vim.git" \
)

#if [[ ! -d ~/.oh-my-zsh ]]; then
#    print -P "%BCloning Oh my ZSH!"
#    git clone $omzrepo $HOME/.oh-my-zsh
#fi


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
    # metafiles; don't link them
    [[ $dotfile = 'setup.sh' ]] && continue
    [[ $dotfile = 'README.md' ]] && continue
    [[ $dotfile = 'py' ]] && continue
    [[ $dotfile = 'bin' ]] && continue

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
