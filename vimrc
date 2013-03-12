" ~/.vimrc
" Eryn Wells <eryn@erynwells.me>

set nocompatible        "use enhanced vim features

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set autoread            "reread files changed outside of vim
set noautowrite         "don't write files before commands like :next and :make

set ffs=unix,dos,mac    "order of line ending formats to try

set hidden              " allow hidden buffers (rather than closing them)

set number              " show line numbers
"set relativenumber      " line numbers are relative to current line rather
                        "   than absolute
set ruler               " show ruler (line and col count)
set showmode            " show mode
set showcmd             " show last command
set title               " change terminal title
set visualbell          " don't beep
set noerrorbells        " PLEASE don't beep
set ttyfast             " fast terminals

set wrap                " wrap long lines
set linebreak           " break at between words
set textwidth=80        " wrap at 80 characters
set colorcolumn=80      " highlight 80th column
set showmatch           " show matching things: (), {}, [], etc

set fo+=n               " format numbered lists properly

set nolist              " don't show spaces, newlines, etc by default
set lcs+=tab:▸\         " show tabs
set lcs+=eol:¬          " show end-of-lines
set lcs+=trail:･        " show trailing spaces
set lcs+=extends:→      " show long lines (that go offscreen)
set lcs+=nbsp:･         " show non-breaking spaces

set ignorecase          " ignore case in searches
set smartcase           " case-sensitive search if pattern contains a capital
set incsearch           " show search matches as you type
set gdefault            " apply searches globally to a line by default

set laststatus=2        " always show status line

" This is basically default status line, with a few exceptions:
"  1. Show buffer number before filename (%n:)
"  2. Show filetype between line number and percentage
set statusline=%2n:%<%f\ %((%Y)%)\ %(%h%m%r%)%=%-12(%l,%c%V%)%P

" use PCREs for searches
nnoremap / /\v
vnoremap / /\v

set spelllang=en        " set spelling language
if has('win32') || has('win64')
    set spellfile=~/_vim/spelling.en.add
else
    set spellfile=~/.vim/spelling.en.add
endif

set noswapfile          " don't keep swap files
set nobackup            " don't keep backup files
set backupdir=~/.vim/backup
                        " save backup files here
set undofile            " save undo history
set undodir=~/.vim/undo " save undo files here
set history=1000        " remember 1000 commands in history
set undolevels=1000     " keep lots of undo history
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
                        " I have *NO* idea what this does...

set backspace=indent,eol,start
                        " backspace over everything in insert mode

set tabstop=8           " tabs are always 8 spaces
set shiftwidth=4        " shift lines 4 spaces with >> and <<
set softtabstop=4       " tab key inserts 4 spaces
set shiftround          " round off indent to multiple of shiftwidth
set expandtab           " always use spaces
set nojoinspaces        " insert 1 space instead of 2 after punctuation on line
                        "   join
set autoindent          " always use autoindenting
set copyindent          " copy previous indentation on autoindent

set scrolloff=3         " scroll 3 lines ahead of point
set sidescrolloff=5     " scroll 5 columns ahead of point

set pastetoggle=<F12>    " toggle paste mode with F12

" completion menu
set wildmenu
set wildmode=longest,list

" Wild ignores
" build artifacts
set wildignore+=*.o,*.pyc,*~,.lo
set wildignore+=*.db,*.pdf,*.jpg,*.jpeg,*.png,*.gif
set wildignore+=.git,env,migrations

if has('mouse')
    set mouse=a
endif

set modeline
set modelines=12

" Add my generated system tags files
set tags=./tags,tags
" These two are the important ones
set tags+=~/.tags/apple_frameworks.tags
set tags+=~/.tags/usr.tags
"set tags+=~/.tags/3rdparty_frameworks.tags
" This thing is 853 MB on my last count. It *probably* doesn't need to be
" included all the time...
"set tags+=~/.tags/usr_local.tags


" use syntax highlighting if the terminal can support it (or we're in a GUI)
if &t_Co > 2 || has('gui_running')
    syntax on           " turn on syntax highlighting
endif

set bg=dark

" use solarized colorscheme if the terminal can support it (or we're in a GUI)
let g:solarized_termtrans = 1
let g:solarized_visibility = 'low'
colorscheme solarized

" tell SnipMate who I am
let g:snips_author = 'Eryn Wells <eryn@erynwells.me>'

" set the Gundo preview window on the bottom
let g:gundo_preview_bottom = 1

map <silent> <F2> :NERDTreeToggle<CR>
map <silent> <F3> :GundoToggle<CR>
map <silent> <F4> :setlocal invlist<CR>

inoremap jj <ESC>

" allow starting commands with ; instead of :
nnoremap ; :

" tab to skip between braces and such in normal
nnoremap <tab> %
vnoremap <tab> %

" disable the help key!
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" make switching windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Usual EMACS (oh the horror!) begin-line and end-line keys for first and last
" buffer.
"nnoremap <silent> <C-a> :bfirst<CR>
"nnoremap <silent> <C-e> :blast<CR>
" Move between buffers with <C-n> and <C-p>
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>


function! <SID>strip_trailing_whitespace()
    " save last search
    let _s=@/
    " save cursor position
    let l = line('.')
    let c = col('.')
    " do the clean up
    %s/\s\+$//e
    " restore saved stuff
    let @/=_s
    call cursor(l, c)
endfunction


function! <SID>FindProjectFileOrDirectory(fod)
    let l:dir = getcwd()
    " Search up the path, starting at the current working directory, for the
    " file or directory given in a:fod and return the path to it, if it exists.
    while l:dir != "/"
        let l:file_or_dir = l:dir . "/" . a:fod
        if filereadable(l:file_or_dir) || isdirectory(l:file_or_dir)
            return l:file_or_dir
        endif
        let l:dir = fnamemodify(l:dir, ':h')
    endwhile
    return ""
endfunction


function! GetProjectRuntimeDirectory()
    return <SID>FindProjectFileOrDirectory("vim")
endfunction


function! GetProjectFile()
    return <SID>FindProjectFileOrDirectory("project.vim")
endfunction


function! <SID>SourceProjectFile()
    let l:project_file = GetProjectFile()
    if l:project_file != ""
        exec "source " . l:project_file
    endif
endfunction


function! <SID>AddProjectRuntimeDirectory()
    let l:project_rtp = GetProjectRuntimeDirectory()
    if isdirectory(l:project_rtp)
        exec "set rtp+=" . l:project_rtp
    endif
endfunction


let mapleader=','

" strip all trailing whitespace in the current file
nnoremap <silent> <leader>W :call <SID>strip_trailing_whitespace()<CR>

" Source .vimrc and project.vim files
nmap <leader>V :source $MYVIMRC<CR>
nmap <leader>P :call <SID>SourceProjectFile()<CR>
" Edit my .vimrc and project.vim files
nmap <leader>eV :edit $MYVIMRC<CR>
nmap <leader>eP :exec 'edit ' . GetProjectFile()<CR>

" hide search terms
nmap <silent> <leader><space> :setlocal invhlsearch<CR>
" find all
nmap <leader>fa :%s/\v

" Open the snippet file for the current filetype
nmap <leader>esn :e ~/.vim/bundle/snipmate/snippets/<C-r>=&filetype<CR>.snippets<CR>
" Open the ftplugin-after script for the current filetype
nmap <leader>eft :e ~/.vim/after/ftplugin/<C-r>=&filetype<CR>.vim<CR>

" Toggle position highlighting
nmap <silent> <leader>cl :setlocal invcursorline<CR>
nmap <silent> <leader>cc :setlocal invcursorcolumn<CR>


" Text bubbling (these depend on tpope's unimpaired plugin)
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Select last edited text after cut and paste
nmap gV `[v`]


" Command-T should open files in tabs when I hit <CR>; move opening files in
" buffers to <C-b>
"let g:CommandTAcceptSelectionMap='<C-b>'
"let g:CommandTAcceptSelectionTabMap='<CR>'

" GitGutter shows changed lines in files.
let g:gitgutter_enabled = 0
highlight clear SignColumn
nmap <silent> <leader>gg :ToggleGitGutter<CR>

if has('autocmd')
    filetype plugin indent on

    " Jump to last known cursor position unless it's the first line, or past the
    " end of the file
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    " All my projects are in the ~/Code directory. Look for and source a
    " project.vim file if one exists.
    autocmd VimEnter ~/Code/*
        \ call <SID>SourceProjectFile()
    autocmd VimEnter ~/Code/*
        \ call <SID>AddProjectRuntimeDirectory()

    " Reload snippets after editing the snippets file. Snippet files are
    " <filetype>.snippets. Get <filetype> from the filename and reload the
    " snippets for that type.
    "autocmd BufWritePost *.snippets
    "    \ :call ReloadSnippets(expand('%:t:r'))

    " Clean whitespace before saving: Python, C, HTML, and Objective-C
    autocmd BufWritePre *.py,*.h,*.c,*.html,*.m,*.mm,*.cc,*.hh
        \ call <SID>strip_trailing_whitespace()
endif

if has('unix')
    if filereadable($HOME."/.vimrc.local")
        source $HOME/.vimrc.local
    endif
endif
