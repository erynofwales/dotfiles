" ~/.vimrc
" Eryn Wells <eryn@erynwells.me>

source ~/.vimrc.common

" Set this first for Vundle
set nocompatible        " use enhanced vim features

set backupdir=$VIM/backup
                        " save backup files here
set undodir=$VIM/undo   " save undo files here

" Shared data file. The vim and nvim formats are incompatible so this needs to 
" be set differently for vim and nvim.
set viminfofile=$VIM/vim_shared_data

" Shada data. Parameters as follows: (see :help shada)
"   %   number of buffers to save and restore when no file argument is given
"   '   maximum number of previously edited files for which marks are remembered
"   h   disable highlighted search patterns on start
"   /   omitted, so all search history is saved
"   <   maximum number of lines saved for each register
"   :   maximum number of lines of command history to save
"   s   shada entries over 100 KiB are skipped
set viminfo=%100,'100,h,<1000,:100,s100

