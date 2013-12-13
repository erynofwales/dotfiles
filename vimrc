" ~/.vimrc
" Eryn Wells <eryn@erynwells.me>

" Set the location of my vim directory.
let $VIM = $HOME."/.vim"

" Load Pathogen to get all my plugins.
try
    call pathogen#infect()
catch
    call pathogen#runtime_append_all_bundles()
endtry
call pathogen#helptags()


"
" CONFIG OPTIONS
"

set nocompatible        " use enhanced vim features

set autoread            " reread files changed outside of vim
set noautowrite         " don't write files before commands like :next and :make

set ffs=unix,dos,mac    " order of line ending formats to try

set hidden              " allow hidden buffers (rather than closing them)
set splitright          " Open vertical splits to the right of the current window
set splitbelow          " Open horizontal splits below the current window

set number              " show line numbers
set ruler               " show ruler (line and col count)
set showmode            " show mode
set showcmd             " show last command
set title               " change terminal title
set visualbell          " don't beep
set noerrorbells        " PLEASE don't beep
set ttyfast             " fast terminals

set wrap                " wrap long lines
set linebreak           " break at between words
set textwidth=120       " wrap at 120 characters
set colorcolumn=80,120  " highlight 80th and 120th columns
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
"  2. Show filetype after file name
set statusline=%2n:%<%f\ %((%Y)%)\ %(%h%m%r%)%=%-12(%l,%c%V%)%P

set spelllang=en        " set spelling language
set spellfile=$VIM/spelling.en.add

set noswapfile          " don't keep swap files
set nobackup            " don't keep backup files
set backupdir=$VIM/backup
                        " save backup files here
set undofile            " save undo history
set undodir=$VIM/undo   " save undo files here
set history=1000        " remember 1000 commands in history
set undolevels=1000     " keep lots of undo history
set viminfo=%100,'100,/100,h,\"500,:100,n$VIM/.viminfo
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
set wildignore+=*.o,*.pyc,*~,.lo,*.class
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

" Try to use the solarized colorscheme if the terminal can support it (or we're in a GUI)
try
    colorscheme solarized
    let g:solarized_termtrans = 0
    let g:solarized_contrast = 'normal'
    let g:solarized_visibility = 'low'
endtry

" Empty snipmate options dictionary
let g:snipMate = {}
" tell SnipMate who I am
let g:snips_author = 'Eryn Wells <eryn@erynwells.me>'
" Set up some snippet scope aliases
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases["java"] = "android"

" set the Gundo preview window on the bottom
if has('loaded_gundo')
    let g:gundo_preview_bottom = 1
    map <silent> <F3> :GundoToggle<CR>
endif

noremap <silent> <F2> :NERDTreeToggle<CR>
noremap <silent> <F3> :GundoToggle<CR>
noremap <silent> <F4> :setlocal invlist<CR>

inoremap kj <ESC>

" allow starting commands with ; instead of :
nnoremap ; :

" tab to skip between braces and such in normal
nnoremap <silent> <tab> %
vnoremap <silent> <tab> %

" use PCREs for searches
nnoremap / /\v
vnoremap / /\v

" disable the help key!
noremap <silent> <F1> <ESC>

" make switching windows easier
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

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


" Key Mappings {{{
let mapleader=','

" hide search terms
nnoremap <silent> <leader><space> :setlocal invhlsearch<CR>
" find all
nnoremap <leader>fa :%s/\v

" strip all trailing whitespace in the current file
nnoremap <silent> <leader>W :call <SID>strip_trailing_whitespace()<CR>

" Source .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Edit my .vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
" Edit the snippet file for the current filetype
nnoremap <leader>es :e ~/.vim/bundle/snipmate-snippets/snippets/<C-r>=&filetype<CR>.snippets<CR>
" Edit the ftplugin-after script for the current filetype
nnoremap <leader>ef :e ~/.vim/after/ftplugin/<C-r>=&filetype<CR>.vim<CR>

" hide search terms
nnoremap <silent> <leader><space> :setlocal invhlsearch<CR>
" find all
nnoremap <leader>fa :%s/\v

" Toggle position highlighting
augroup cursor_position
    autocmd!
    autocmd InsertEnter * setlocal nocursorline
    autocmd InsertLeave * setlocal cursorline
augroup END

nnoremap <silent> <leader>cl :setlocal invcursorline<CR>
nnoremap <silent> <leader>cc :setlocal invcursorcolumn<CR>

" Text bubbling (these depend on tpope's unimpaired plugin)
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

" Select last edited text after cut and paste
nnoremap gV `[v`]

" }}}


" Command-T should open files in tabs when I hit <CR>; move opening files in
" buffers to <C-b>
"let g:CommandTAcceptSelectionMap='<C-b>'
"let g:CommandTAcceptSelectionTabMap='<CR>'

" GitGutter shows changed lines in files.
let g:gitgutter_enabled = 0
highlight clear SignColumn
nnoremap <silent> <leader>gg :ToggleGitGutter<CR>

" Autocommands {{{
if has('autocmd')
    filetype plugin indent on

    " Jump to last known cursor position unless it's the first line, or past the
    " end of the file
    augroup RestoreCursorPosition
        autocmd!
        autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END

    " Reload snippets after editing the snippets file. Snippet files are
    " <filetype>.snippets. Get <filetype> from the filename and reload the
    " snippets for that type.
    augroup ReloadSnippets
        autocmd!
        autocmd BufWritePost *.snippets :call ReloadSnippets(expand('%:t:r'))
    augroup END

    " Clean whitespace before saving: Python, C, HTML, and Objective-C
    augroup StripTrailingWhitespace
        autocmd!
        autocmd FileType python call <SID>strip_trailing_whitespace()
        autocmd FileType c,cpp,objc call <SID>strip_trailing_whitespace()
        autocmd FileType html,css call <SID>strip_trailing_whitespace()
    augroup END
endif
" }}}

if has('unix')
    if filereadable($HOME."/.vimrc.local")
        source $HOME/.vimrc.local
    endif
endif
