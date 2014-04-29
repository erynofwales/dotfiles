" tmux.vim
" Language:         tmux config file
" Author:           Eryn Wells <eryn@erynwells.me>
" Last Modified:    2012-12-05

syn clear

setlocal iskeyword+=-

" Session and Client commands
syn keyword tmuxCommand attach attach-session
syn keyword tmuxCommand detach detach-session
syn keyword tmuxCommand has has-session
syn keyword tmuxCommand kill-server kill-session
syn keyword tmuxCommand list-clients lsc
syn keyword tmuxCommand list-commands lscm
syn keyword tmuxCommand list-sessions ls
syn keyword tmuxCommand lock-client lockc
syn keyword tmuxCommand lock-session locks
syn keyword tmuxCommand lock-server
syn keyword tmuxCommand new new-session
syn keyword tmuxCommand refresh refresh-client
syn keyword tmuxCommand rename rename-session
syn keyword tmuxCommand show-messages showmsgs
syn keyword tmuxCommand source source-file
syn keyword tmuxCommand start start-server
syn keyword tmuxCommand suspend-client suspendc
syn keyword tmuxCommand switch-client switchc

" Window and Pane commands
syn keyword tmuxCommand break-pane breakp
syn keyword tmuxCommand capture-pane capturep
syn keyword tmuxCommand choose-client
syn keyword tmuxCommand choose-list
syn keyword tmuxCommand choose-session
syn keyword tmuxCommand choose-tree
syn keyword tmuxCommand choose-window
syn keyword tmuxCommand display-panes displayp
syn keyword tmuxCommand find-window findw
syn keyword tmuxCommand join-pane joinp
syn keyword tmuxCommand kill-pane killp kill-window killw
syn keyword tmuxCommand last-pane lastp last-window lastw
syn keyword tmuxCommand link-window linkw
syn keyword tmuxCommand list-panes lsp list-windows lsw
syn keyword tmuxCommand move-pane movep new-window movew
syn keyword tmuxCommand new-window neww
syn keyword tmuxCommand next-pane nextp next-window nextw
syn keyword tmuxCommand pipe-pane pipep
syn keyword tmuxCommand previous-layout prevl previous-window prev
syn keyword tmuxCommand rename-window renamew
syn keyword tmuxCommand resize-pane resizep
syn keyword tmuxCommand respawn-pane respawnp respawn-window respawnw
syn keyword tmuxCommand rotate-window rotatew
syn keyword tmuxCommand select-layout selectl select-pane selectp select-window selectw
syn keyword tmuxCommand split-window splitw
syn keyword tmuxCommand swap-pane swapp swap-window swapw
syn keyword tmuxCommand unlink-window unlinkw

" Key bindings commands
syn keyword tmuxCommand unbind-key unbind bind-key bind
syn keyword tmuxCommand list-keys lsk
syn keyword tmuxCommand send-keys send
syn keyword tmuxCommand send-prefix

" Option commands
syn keyword tmuxCommand set-option set set-window-option setw

syn keyword tmuxBooleanOption exit-unattached quiet set-clipboard bell-on-alert destroy-unattached detach-on-destroy lock-server mouse-resize-pane mouse-select-pane mouse-select-window mouse-utf8 remember-windows set-remain-on-exit set-titles status status-utf8 visual-activity visual-bell visual-content visual-silent nextgroup=tmuxBoolean skipwhite
syn keyword tmuxNumberOption buffer-limit escape-time base-index display-panes-time display-time history-limit lock-after-time message-limit repeat-time status-interval status-left-length status-right-length nextgroup=tmuxNumber skipwhite
syn keyword tmuxStringOption default-command default-path default-shell default-terminal lock-command set-titles-string status-left status-right terminal-overrides update-environment word-separators nextgroup=tmuxString
syn keyword tmuxBellActionOption bell-action nextgroup=tmuxBellActionOptionValue
syn keyword tmuxModeKeysOption mode-keys nextgroup=tmuxModeKeysOptionValue
syn keyword tmuxStatusJustifyOption status-justify nextgroup=tmuxStatusJustifyOptionValue
syn keyword tmuxStatusPositionOption status-position nextgroup=tmuxStatusPositionOptionValue
syn keyword tmuxColourOption display-panes-active-colour display-panes-colour message-bg message-command-bg message-command-fg message-fg pane-active-border-bf pane-active-border-fg pane-border-bg pane-border-fg status-bg status-fg status-left-bg status-left-fg status-right-bg status-right-fg nextgroup=tmuxColour

" Option values
syn match tmuxNumber /\d\+/
syn region tmuxString start="\"" end="\"" oneline
syn keyword tmuxBoolean on off
syn keyword tmuxPaneLayout even-horizontal even-vertical main-horizontal main-vertical tiled
syn keyword tmuxBellActionOptionValue any none current
syn keyword tmuxModeKeysOptionValue vi emacs
syn keyword tmuxStatusJustifyOptionValue left centre right
syn keyword tmuxStatusPositionOptionValue top bottom

syn keyword tmuxColourAttributes none bright bold dim underscore blink reverse hidden italics
syn match tmuxColour /default\|\(bright\)\?\(black\|red\|green\|yellow\|blue\|magenta\|cyan\|white\)/
syn match tmuxColour /colour[0-9]\|colour[0-9][0-9]\|colour1[0-9][0-9]\|colour2[0-4][0-9]\|colour25[0-5]/
syn match tmuxColour /#\x\{6}/


" Higlighting {{{1
hi def link tmuxCommand                         Statement

hi def link tmuxBooleanOption                   Keyword
hi def link tmuxNumberOption                    Keyword
hi def link tmuxStringOption                    Keyword
hi def link tmuxBellActionOption                Keyword
hi def link tmuxStatusJustifyOption             Keyword
hi def link tmuxStatusPositionOption            Keyword
hi def link tmuxColourOption                    Keyword

hi def link tmuxBoolean                         Constant
hi def link tmuxNumber                          Constant
hi def link tmuxColour                          Constant
hi def link tmuxColourAttributes                Constant
hi def link tmuxPaneLayout                      Constant
hi def link tmuxBellActionOptionValue           Constant
hi def link tmuxModeKeysOptionValue             Constant
hi def link tmuxStatusJustifyOptionValue        Constant
hi def link tmuxStatusPositionOptionValue       Constant

hi def link tmuxStringOptionValue               String
" }}}1
