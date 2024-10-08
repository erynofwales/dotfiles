" ~/.vimrc
" Eryn Wells <eryn@erynwells.me>

source ~/.vimrc.common

if !has('nvim')
    set nocompatible        " use enhanced vim features

    let s:localdir=expand("~/.local/state/vim")
    if !isdirectory(s:localdir)
        call mkdir(s:localdir, "p")
    endif

    let &backupdir=expand(s:localdir . "/backup//" . ",.")
    let &undodir=expand(s:localdir . "/undo//")
    let &viminfofile=expand(s:localdir . "/viminfo")

    " Shada data. Parameters as follows: (see :help shada)
    "   %   number of buffers to save and restore when no file argument is given
    "   '   maximum number of previously edited files for which marks are remembered
    "   h   disable highlighted search patterns on start
    "   /   omitted, so all search history is saved
    "   <   maximum number of lines saved for each register
    "   :   maximum number of lines of command history to save
    "   s   shada entries over 100 KiB are skipped
    set viminfo=%100,'100,h,<1000,:100,s100
endif
