#!/usr/bin/env zsh

dfdir=$(cd "$(dirname "$0")" && pwd)
sys=`uname -s | tr A-Z a-z`

skipitems=(setup.sh README.md py Colors LaunchAgents)

typeset -A vimbundles
vimbundles=(Vundle.vim "https://github.com/gmarik/Vundle.vim.git")

function link {
    local action
    local dest

    if [[ -z $2 ]]; then
        local dotfile_basename=`basename "$1"`
        dest="$HOME/.$dotfile_basename"
    else
        dest="$2"
    fi

    if [[ ! -e "$dest" ]]; then
        action='Linking'
        ln -fs "$1" "$dest"
    else
        action='Skipping'
    fi

    printf "  %8s: %s\n" $action "$dest"
}

print -P "      %BHome:%b $HOME"
print -P "  %BDotfiles:%b $dfdir"
print -P "%BSkip Items:%b $skipitems\n"

print -P "%BRemoving stray dotfile symlinks from $HOME%b"
local link_dest
local link_dirname
local did_remove_at_least_one_symlink=0
for file in ~/.?*; do
    link_dest=`readlink "$file"`
    if [[ $? -ne 0 ]]; then
        # Not a symlink.
        continue
    fi

    link_dirname=`dirname "$link_dest"`
    if [[ "$link_dirname" != "$dfdir" ]]; then
        continue
    fi

    if [[ -e "$link_dest" ]]; then
        continue
    fi

    printf "  Removing: %s\n" "$file"
    rm "$file"
    did_remove_at_least_one_symlink=1
done

if [[ $did_remove_at_least_one_symlink -ne 1 ]]; then
    print "  Nothing to remove"
fi

print -P "%BSymlinking config files%b"
local dotfile
local did_link_at_least_one_dotfile=0
for dotfile in $dfdir/*; do
    if [[ ${skipitems[(r)$dotfile]} == $dotfile ]]; then
        continue
    fi
    if [[ "`basename $dotfile`" == "config" ]]; then
        # Recurse into config and link each item individually
        mkdir -p "$HOME/.config"
        for config_dotfile in $dfdir/config/*; do
            config_dotfile_basename=`basename "$config_dotfile"`
            link "$config_dotfile" "$HOME/.config/$config_dotfile_basename"
        done
    else
        link "$dotfile"
    fi
    did_link_at_least_one_dotfile=1
done

if [[ -f "$HOME/.hushlogin" ]]; then
    print "  touch $HOME/.hushlogin"
    touch "$HOME/.hushlogin"
    did_link_at_least_one_dotfile=1
fi

if [[ $did_link_at_least_one_dotfile -ne 1 ]]; then
    print "  Nothing to link"
fi

print -P "%BFetching Vim modules%b"
cd "$dfdir/vim/bundle"
for module in ${(k)vimbundles}; do
    print -n "  $module"

    if [[ ! -d $module ]]; then
        git clone ${vimbundles[$module]} $module >& -
        if [[ $? -eq 0 ]]; then
            result='done'
        else
            result='failed'
        fi
    fi
done

VIM=nvim
if ! whence -cp nvim >& -; then
    VIM=vim
fi
$VIM +PluginInstall +qall

exit 0
