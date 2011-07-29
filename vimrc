" ~/.vimrc
" Eryn Wells <eryn@3b518c.com>

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible	"use enhanced vim features

set autoread		"reread files changed outside of vim
set noautowrite		"don't write files before commands like :next and :make

set ffs=unix,dos,mac	"order of line ending formats to try

" command line
" always show current mode and cursor position
set ruler
set showmode
set showcmd

" line breaking and wrapping
set wrap
set linebreak
set textwidth=80

" formatting options
set fo+=n	"format numbered lists properly
set fo+=2	"format paragraphs with first line indent different from rest

" list view options
set lcs+=tab:>-		"make tabs look like >--..--- in list mode
set lcs+=eol:$		"make end of line print $ in list mode

" searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" spelling
if has('win32') || has('win64')
    set spellfile=~/_vim/spelling.en.add
else
    set spellfile=~/.vim/spelling.en.add
endif
set spelllang=en
autocmd FileType text set spell

" vim for windows uses _ instead of . to prefix config files
if has('win32') || has('win64')
    set directory=~/_vim/swap
    set backupdir=~/_vim/backup
else
    set directory=~/.vim/swap
    set backupdir=~/.vim/backup
endif

" backup and recovery
set undolevels=500
set updatecount=100
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set history=200

set showmatch

set backspace=indent,eol,start

" tabbing and indenting
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set nojoinspaces

set number
set scrolloff=3
set sidescrolloff=5

set pastetoggle=<F2>

" completion menu
set wildmenu
set wildmode=longest,list
set wildignore+=*.o,*~,.lo,*.pdf

if has('mouse')
    set mouse=a
endif

set modeline
set modelines=12

if &t_Co > 2 || has('gui_running')
    syntax enable
endif

if has('autocmd')
    filetype plugin indent on
    autocmd FileType text setlocal textwidth=76

    " Jump to last known cursor position unless it's the first line, or past the
    " end of the file
    autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
endif

" tell SnipMate who I am
let g:snips_author = 'Eryn Wells <eryn@3b518c.com>'

"if has('autocmd')
"    autocmd BufWritePost .vimrc source $MYVIMRC
"endif

if has('gui_running')
    if has('win32') || has('win64')
	set guifont=Inconsolata:h18
    elseif has('mac')
	set guifont=Menlo:h14
    elseif has('linux')
	set guifont=Inconsolata\ 14
    endif
    set cursorline
    set guioptions-=T	    " turn off toolbar
    set guioptions-=m	    " turn off toolbar

    set bg=light
    colorscheme solarized
else
    colorscheme default
endif

nmap <F3> :GundoToggle<CR>

let mapleader=','
nmap <leader>v :tabedit $MYVIMRC<CR>
