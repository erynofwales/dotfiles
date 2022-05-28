set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc.common

let g:python_host_prog=$HOME.'/.virtualenvs/neovim/bin/python'
let g:python3_host_prog=$HOME.'/.virtualenvs/neovim/bin/python3'

" Backup files are saved here when files are overwritten
set backupdir=stdpath("data")."/backup"

" Swap files are saved here while files are being edited
set directory=stdpath("data")."/swap"

" Shared data file lives here
set shadafile=stdpath("data")."/nvim_shared_data"

" Fields to save in the Shada file. Parameters as follows: (see :help shada)
"   %   number of buffers to save and restore when no file argument is given
"   '   maximum number of previously edited files for which marks are remembered
"   h   disable highlighted search patterns on start
"   /   omitted, so all search history is saved
"   <   maximum number of lines saved for each register
"   :   maximum number of lines of command history to save
"   s   shada entries over 100 KiB are skipped
set shada=%100,'1000,h,<1000,:1000,s100

" Undo history for files is saved here
set undodir=stdpath("data")."/undo"
