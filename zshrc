# .zshrc
# vim:ft=zsh:fdm=marker:sw=4:sts=4:
#
# ZSH init for interactive shells
#
# Eryn Wells <eryn@erynwells.me>

PROMPT_THEME='loquacious'
ZLE_MODE='vim'


# load bash/zsh/ksh agnostic configurations
[[ -e $HOME/.rc ]] && source $HOME/.rc

print_heading -l 1 "Initializing interactive Z Shell"


function configure_general #{{{
{
    print_info -l 2 'Configuring general ZSH settings'

    # Report seconds since shell was invoked in milliseconds
    typeset -F SECONDS

    print_info_sub -l 3 'Setting shell options'
    # See zshoptions(1)
    setopt EXTENDED_GLOB \
           MULTIOS \
           AUTO_REMOVE_SLASH \
           COMPLETE_IN_WORD
} #}}}


# Configure oh-my-zsh
function configure_omz #{{{
{
    if [[ ! -d ~/.oh-my-zsh ]]; then
        print_error -l 2 "No ~/.oh-my-zsh directory; skipping"
        return
    fi

    print_info -l 2 'Configuring Oh My ZSH!'

    ZSH=$HOME/.oh-my-zsh
    DISABLE_AUTO_UPDATE="true"
    COMPLETION_WAITING_DOTS="true"

    plugins=(autojump brew encode64 fasd gnu-utils history osx python)

    source $ZSH/oh-my-zsh.sh

    alias v='f -t -e vim -b viminfo'
} #}}}


function configure_zle #{{{
{
    print_info -l 2 'Configuring ZLE'

    print_info_sub -l 5 "Using $ZLE_MODE command line editing mode"
    [[ -z "$ZLE_MODE" ]] && ZLE_MODE='vim'
    if [[ $ZLE_MODE == 'vim' ]]; then
        bindkey -v
    elif [[ $ZLE_MODE == 'emacs' ]]; then
        bindkey -e
    fi

    # Allow deleting over the start of insert mode
    zle -A .backward-delete-char vi-backward-delete-char

    # Edit commands in $EDITOR on 'v' in command mode
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd v edit-command-line
} #}}}


function configure_modules_and_functions #{{{
{
    print_info -l 2 'Loading modules'

    local myfpath="$HOME/.zsh/func"
    print_info_sub -l 2 "Adding $myfpath to fpath"
    fpath=($myfpath/makers $myfpath $fpath)

    load_module 'makers'

    print_info -l 3 "Loading pw module"
    autoload pw

    print_info -l 3 "Loading refresh_system_tags"
    autoload refresh_system_tags
} #}}}


function configure_prompt #{{{
{
    print_info -l 2 "Configuring prompt: $PROMPT_THEME"
    autoload -U promptinit
    promptinit
    prompt $PROMPT_THEME
} #}}}


function configure_zsh_aliases #{{{
{
    print_info -l 3 'Creating ZSH-specific aliases'
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
} #}}}


function configure_history #{{{
{
    print_info -l 2 'Setting up history'
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
} #}}}


function configure_completion #{{{
{
    print_info -l 2 'Initializing completion system'

    autoload -U compinit
    compinit

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
} #}}}


function configure_vcs_info #{{{
{
    print_info -l 3 'Loading vcs_info'

    autoload -U add-zsh-hook
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' disable p4 bzr cdv darcs mtn svk tla cvs svn
    zstyle ':vcs_info:*' enable git

    zstyle ':vcs_info:git:general:*' formats '%b'

    # Export the current Git branch before every prompt.
    function export_gitbranch {
        vcs_info general
        export gitbranch=${vcs_info_msg_0_}
    }

    add-zsh-hook precmd export_gitbranch
} #}}}


configure_general
configure_omz
configure_zle
configure_modules_and_functions 
configure_zsh_aliases
configure_history
configure_completion
configure_vcs_info
configure_prompt


if [ -e $HOME/.zshrc.$SYS ]; then
    print_info -l 3 "Sourcing ${SYS}-specific Z Shell settings"
    source $HOME/.zshrc.$SYS
fi

if [ -e $HOME/.zshrc.local ]; then
    print_info -l 3 "Sourcing local Z Shell settings"
    source $HOME/.zshrc.local
fi
