# .zshrc
# vim: ft=zsh
#
# ZSH init for interactive shells
#
# Eryn Wells <eryn@erynwells.me>

PROMPT_THEME='loquacious'


# load bash/zsh/ksh agnostic configurations
[ -e $HOME/.rc ] && source $HOME/.rc


# Report seconds since shell was invoked in milliseconds
typeset -F SECONDS

print_info_noisy 1 "Initializing interactive Z Shell"

# Function path
function {
    local myfpath="$HOME/.zsh/func"
    fpath=($myfpath/makers $myfpath $fpath)
}

print_info_sub_noisy 2 "Loading vcs_info module"
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git 


print_info_sub_noisy 2 "Configuring prompt: $PROMPT_THEME"
autoload -U promptinit
promptinit
prompt $PROMPT_THEME


print_info_sub_noisy 2 'Setting shell options'
setopt \
    EXTENDED_GLOB \
    MULTIOS


print_info_sub_noisy 3 'Creating aliases'
alias pd='pushd'
alias pod='popd'

#alias -g nc='netcat'
alias -g lessnw='less -S'

# suffix aliases
alias -s c='vim'
alias -s tex='vim'
alias -s txt='vim'
alias -s xml='vim'
alias -s jar='java -jar'

# History settings
print_info_sub_noisy 4 'Setting up history'
setopt \
    APPEND_HISTORY \
    EXTENDED_HISTORY \
    INC_APPEND_HISTORY \
    HIST_FIND_NO_DUPS \
    HIST_IGNORE_SPACE \
    HIST_NO_STORE \
    HIST_IGNORE_DUPS \
    HIST_REDUCE_BLANKS

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$HOME/.zhistory"

# command line editing mode
function {
    local mode='vim'
    print_info_sub_noisy 5 "Using $mode command line editing mode"
    if [[ $mode == 'vim' ]]; then
        bindkey -v
    elif [[ $mode == 'emacs' ]]; then
        bindkey -e
    fi
}


###
# Completion
###

print_info_sub_noisy 2 'Initializing completion system'

# load completion system
autoload -U compinit
compinit

# Completion options
setopt \
	AUTO_REMOVE_SLASH \
	COMPLETE_IN_WORD

# Cache completions
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

# For rm, cp, and mv don't complete if file is on the line already
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes

# Remove trailing slashes in directory arguments
zstyle ':completion:*' squeeze-slashes true

# Never select parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Expand partial paths
zstyle ':completion:*' expand 'yes'

# Show a pretty menu of killable processes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select

###
# FUNCTIONS
###

# Generate a password
print_info_sub_noisy 3 "Loading pw module"
autoload pw

# Maker module -- various functions for makin' stuff
print_info_sub_noisy 3 "Loading makers module"
for func in `ls $HOME/.zsh/func/makers`; do
    autoload $func
done

# Go up $1 directories, where $1 is an integer (saves me from having to type ../
# ad nauseum)
function up {
    if [[ -z $1 ]]; then
        cd ..
    else
        local updir=''
        for (( i=0; $i < $1; i++ ))
        do
            updir="../$updir"
        done
        cd $updir
    fi
}

if [ -e $HOME/.zshrc.$SYS ]; then
    print_info_noisy 3 "Sourcing ${SYS}-specific Z Shell settings"
    source $HOME/.zshrc.$SYS
fi

if [ -e $HOME/.zshrc.local ]; then
    print_info_noisy 3 "Sourcing local Z Shell settings"
    source $HOME/.zshrc.local
fi
