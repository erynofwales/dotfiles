# .zshrc
# Eryn Wells <eryn@3b518c.com>

# PROMPT
#   :--:user@host:dir%
#   Dash one gets filled with * when there are background jobs
#   Dash two gets filled with ! when the last command failed
#   Colors are determined based on terminal type (I think there's a better way)
#   With elevated privilieges, user is colored red and/or bolded
# RPROMPT (currently unused)
#   Time in 24 hour format
#   Current working directory and parent
autoload is-at-least
if (is-at-least '4.3.7'); then
    bgjob="%(1j.%B%F{magenta}*%F{default}%b.)"
    cmdstat="%(0?..%B%F{red}!%F{default}%b)"
    isroot="%(!.%B%F{red}# %F{default}%b.)"
else
    autoload -U colors
    colors
    bgjob="%(1j.%{$fg_bold[magenta]%}*%{$reset_color%}.)"
    cmdstat="%(0?..%{$fg_bold[red]%}!%{$reset_color%})"
    isroot="%(!.%{$fg_bold[red]%}# %{$reset_color%}.)"

    # where do I include these?
    #bgjob="%(1j.%B*%b.)"
    #cmdstat="%(0?..%B!%b)"
    #isroot="%(!.%B#%b.)"
    #mytime="%T"
fi

PROMPT=" %(?.%h.%B%F{red}%h%F{default}%b) %* %(!.%B%F{red}.)%3~ %#%(!.%F{default}%b.) "
RPROMPT="%m"

precmd ()
{
    # Set xterm and screen titles
    [ -n $DISPLAY ] && print -Pn "\e]2;%n@%m\a"
}

# Shell options
setopt \
    TRANSIENT_RPROMPT \
    EXTENDED_GLOB \
    MULTIOS

# load bash/zsh/ksh agnostic configurations
source $HOME/.rc

#alias -g nc='netcat'
alias -g lessnw='less -S'

# suffix aliases
alias -s c='vim'
alias -s tex='vim'
alias -s txt='vim'
alias -s xml='vim'
alias -s jar='java -jar'

# History settings
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

#[ -n "$DISPLAY" ] && alias -s pdf='evince'
#[ -n "$DISPLAY" ] && alias -s dvi='evince'

# host specific initialization
[ -e $HOME/.zshrc-local ] && . ~/.zshrc-local

# emacs command line editing
bindkey -v


#
# Completion
#

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


###
# FUNCTIONS
###

# function path
fpath=($HOME/.zsh/func $fpath)

# Wikipedia lookup, courtesy of msanders@github
autoload wiki
autoload mkmdir
autoload pw
autoload mkcmod

# Go up n directories (saves me from having to type ../ ad # nauseum)
function up {
    if [[ -z $1 ]]; then
        pushd ..
    else
        updirs=()
        for (( i=0; $i < $1; i++ )); do updirs+='..' done
        pushd ${(j./.)updirs}
    fi
}
