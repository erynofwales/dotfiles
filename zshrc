# .zshrc
# Eryn Wells <eryn@erynwells.me>

# PROMPT
#   ' histnum bgjobsflag time (%|#)'
#   Colors are determined based on zsh capability (>= version 4.3.7)
#   With elevated privilieges, % is a red #
# RPROMPT
#   Hostname:Current directory to three places
autoload is-at-least
if (is-at-least '4.3.7'); then
    bgjob="%(1j.%B%F{magenta}* %F{default}%b.)"
    hist="%(0?.%h.%B%F{red}%h%F{default}%b)"
    isroot="%(!.%B%F{red}%#%F{default}%b.%#)"
else
    bgjob="%(1j.%{$fg_bold[magenta]%}* %{$reset_color%}.)"
    hist="%(0?.%h.%{$fg_bold[red]%}%h%{$reset_color%})"
    isroot="%(!.%{$fg_bold[red]%}%#%{$reset_color%}.%#)"

    # where do I include these?
    #bgjob="%(1j.%B*%b.)"
    #cmdstat="%(0?..%B!%b)"
    #isroot="%(!.%B#%b.)"
    #mytime="%T"
fi

PROMPT=" $hist $bgjob$isroot "


precmd_xterm_title()
{
    # Set xterm and screen titles
    [ -n $DISPLAY ] && print -Pn "\e]2;%n@%m\a"
}

precmd_separator()
{
    # time divider
    local fillnum=$COLUMNS
    local sep=''
    for (( i=0; $i < $fillnum; i++)); do sep="-$sep"; done
    print -P "%B%F{black}$sep"
}

precmd_separator_info()
{
    pstr=`print -P "\-\-\( %n@%m \)\-\-\( %~ \)"`
    time=`print -P "\( %T \)\-\-"`
    filler=$(($COLUMNS - ${#pstr} - ${#time}))
    for (( i=0; $i < $filler; i++)); do
        pstr="${pstr}-"
    done
    print -P "%K{black}$pstr$time%k"
}

precmd_git_rprompt()
{
    gstat=`git status 2>/dev/null`
    if [[ $? != 0 ]]; then 
        RPROMPT=''
        return
    fi
    branch=`echo $gstat | sed -n -e '2,$d' \
                                 -e 's/.*\ \([^\ ^:\\*?\[]*\)$/\1/p'`
    RPROMPT="%F{yellow}$branch%f"
    echo $gstat | grep '^nothing' 1>/dev/null 2>&1
    if [[ $? != 0 ]]; then
        RPROMPT="%B%F{red}*%f%b$RPROMPT"
    fi
}

precmd_functions=(precmd_xterm_title precmd_separator_info precmd_git_rprompt)

# Shell options
setopt \
    TRANSIENT_RPROMPT \
    EXTENDED_GLOB \
    MULTIOS

# load bash/zsh/ksh agnostic configurations
source $HOME/.rc

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

# Go up $1 directories, where $1 is an integer (saves me from having to type ../
# ad nauseum)
function up {
    if [[ -z $1 ]]; then
        pushd ..
    else
        local updir=''
        for (( i=0; $i < $1; i++ ))
        do
            updir="../$updir"
        done
        pushd $updir
    fi
}


# Toggle showing a separator before every command
function tsep {
    if (($precmd_functions[(Ie)precmd_separator] > 0)); then
        precmd_functions=${precmd_functions#precmd_separator}
    else
        precmd_functions+=(precmd_separator)
    fi
}
