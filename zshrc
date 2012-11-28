# .zshrc
# vim: ft=zsh
#
# ZSH init for interactive shells
#
# Eryn Wells <eryn@erynwells.me>

# load bash/zsh/ksh agnostic configurations
[ -e $HOME/.rc ] && source $HOME/.rc

print_info_noisy 1 "Initializing interactive Z Shell"

autoload is-at-least
#
# Report seconds since shell was invoked in milliseconds
typeset -F SECONDS

print_info_sub_noisy 2 'Setting up prompt'

is_first_prompt=1

prompt_newline()
{
    # Don't print newlines the first time the prompt is displayed.
    if [[ -n $is_first_prompt ]]; then
        unset is_first_prompt
        [[ -z $SSH_CONNECTION ]] && return
    fi
    echo
}

precmd_xterm_title()
{
    # Set xterm and screen titles
    [[ -n "$DISPLAY" ]] && print -Pn "\e]2;%n@%m\a"
}

if (is-at-least '4.3.7'); then
    precmd_prompt() {
        PROMPT_LINE="%(!.%B%F{red}%#%F{default}%b.%#) "
    }

    precmd_flags_rprompt() {
        # background jobs
        RPROMPT="%(1j.[%B%F{magenta}%j%F{default}%b].)"
        # exit status
        RPROMPT+="%(0?..[%B%F{red}%?%F{default}%b])"
    }
else
    precmd_prompt() {
        PROMPT_LINE="%(!.%{$fg_bold[red]%}%#%{$reset_color%}.%#) "
    }

    precmd_flags_rprompt() {
        # background jobs
        RPROMPT="%(1j.[%{$fg_bold[magenta]%}%j%{$reset_color%}].)"
        # exit status
        RPROMPT+="%(0?..[%{$fg_bold[red]%}%?%{$reset_color%}])"
    }
fi

precmd_info()
{
    PROMPT_NAME='%B%F{magenta}%n%f%b'
    PROMPT_HOST='%B%F{red}%m%f%b'
    PROMPT_CWD='%B%F{green}%~%f%b'
}

precmd_git_branch()
{
    local git_branch_output
    git_branch_output=`git branch 2>/dev/null`
    if [[ $? -eq 0 ]]; then
        export gitbranch=`echo $git_branch_output | grep '^\*' | cut -d' ' -f2`
        PROMPT_REPO="%B%F{cyan}$gitbranch%f%b"
    else
        PROMPT_REPO=''
    fi
}

precmd_assemble_prompt()
{
   local p="$PROMPT_NAME "
   [[ -n "$SSH_CONNECTION" ]] && p+="on $PROMPT_HOST "
   p+="at $PROMPT_CWD"
   if [[ -n "$PROMPT_REPO" ]]; then
      p+=" on $PROMPT_REPO"
   fi
   PROMPT="$p
$PROMPT_LINE"
}

precmd_functions=(precmd_xterm_title prompt_newline \
                  precmd_prompt precmd_info precmd_git_branch \
                  precmd_flags_rprompt)
preexec_functions=(prompt_newline)


print_info_sub_noisy 2 'Setting options'
# Shell options
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

# Function path
function {
    local myfpath="$HOME/.zsh/func"
    fpath=($myfpath/makers $myfpath $fpath)
}

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

# Put this down here 'cause some of the local stuff might modify the prompt or
# add functions to $precmd_functions. Doing this here ensures it's always the
# last function to be executed before the prompt is displayed.
precmd_functions+=(precmd_assemble_prompt)
