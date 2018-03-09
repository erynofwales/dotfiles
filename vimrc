" ~/.vimrc
" Eryn Wells <eryn@erynwells.me>

" Set the location of my vim directory.
let $VIM = $HOME."/.vim"

" Set this first for Vundle
set nocompatible        " use enhanced vim features
filetype off            " Needs to be off for Vundle to work (?)

"
" VUNDLE PLUGINS
"

set rtp+=$VIM/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Filetypes
Plugin 'keith/swift.vim'
Plugin 'elmcast/elm-vim'

" Editing helpers
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'PeterRincker/vim-argumentative'

" Documentation and completion
Plugin 'rizzatti/funcoo.vim'    " Required for dash
Plugin 'rizzatti/dash.vim'
"Plugin 'valloric/YouCompleteMe'

Plugin 'sjl/gundo.vim'          " Undo helper
Plugin 'scrooloose/nerdtree'
Plugin 'wincent/command-t'

"Plugin 'erynofwales/vim-fancyfolds'
Plugin 'apple-swift', {'pinned': 1}
Plugin 'rust-lang/rust.vim'

" Colors~
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'

" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()

"
" CONFIG OPTIONS
"

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
set colorcolumn=80,89,120
                        " highlight these columns
set showmatch           " show matching things: (), {}, [], etc

set fo+=n               " format numbered lists properly

set nolist
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
if !has('nvim')
    set viminfo=%100,'100,/100,h,\"500,:100,n$VIM/.viminfo
else
    set viminfo=%100,'100,/100,h,\"500,:100,n$VIM/.nviminfo
endif
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

set pastetoggle=<F1>    " toggle paste mode with F12

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

if $TERM_PROGRAM ==# "Apple_Terminal"
    set title
    " Apple Terminal lets you set the current document with this escape.
    set t_ts=]6;
    " Alarm character.
    set t_fs=
    " Write out the full path to the current file in the title string.
    set titlestring=file://%{expand('%:p')}
endif

" use syntax highlighting if the terminal can support it (or we're in a GUI)
if &t_Co > 2 || has('gui_running')
    syntax on           " turn on syntax highlighting
endif

" Dark backgrounds are the only way to travel
set bg=dark

" Try to use the solarized colorscheme if the terminal can support it
let g:solarized_termtrans = 0           " transparent terminals
let g:solarized_visibility = 'low'      " visibility of list chars
try
    colorscheme solarized
endtry

" Empty snipmate options dictionary
let g:snipMate = {}
" tell SnipMate who I am
let g:snips_author = 'Eryn Wells <eryn@erynwells.me>'
" Set up some snippet scope aliases
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases["java"] = "android"

" set the Gundo preview window on the bottom
let g:gundo_preview_bottom = 1

"
" PATHS
"

set path=.,,/usr/local/include,/usr/include

if has('mac')
    let g:xcode_path = system('xcode-select -p')
    let s:clang_library_path = g:xcode_path . 'Toolchains/XcodeDefault.xctoolchain/usr/lib'
    if isdirectory(s:clang_library_path)
        let g:clang_library_path = s:clang_library_path
    endif
endif

"
" Mappings
"

noremap <silent> <F2> :NERDTreeToggle<CR>
noremap <silent> <F3> :GundoToggle<CR>
noremap <silent> <F4> :setlocal invlist<CR>

inoremap kj <ESC>

" allow starting commands with ; instead of :
nnoremap ; :

" tab to skip between braces and such in normal
"nnoremap <silent> <tab> %
"vnoremap <silent> <tab> %

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


function! SelectaCommand(choice_command, selecta_args, vim_command)
    try
        silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
    catch /Vim:Interrupt/
        " Swallow ^C so the redraw below happens; otherwise there will be
        " leftovers of selecta on screen.
        redraw!
        return
    endtry
    redraw!
    exec a:vim_command . " " . selection
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

nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

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
"let g:gitgutter_enabled = 0
"highlight clear SignColumn
"nnoremap <silent> <leader>gg :ToggleGitGutter<CR>

" Don't underline folded lines
highlight Folded cterm=bold term=bold ctermfg=NONE ctermbg=NONE

" Line numbers are a touch darker...
"highlight LineNr ctermfg=8 ctermbg=0

" Don't underline the CursorLine in color terminals; use dark black.
highlight CursorLine term=underline cterm=NONE ctermbg=0
highlight CursorLineNr term=underline cterm=NONE ctermfg=7 ctermbg=0

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
    "augroup ReloadSnippets
    "    autocmd!
    "    autocmd BufWritePost *.snippets :call ReloadSnippets(expand('%:t:r'))
    "augroup END

    augroup WrapAt80
        autocmd!
        autocmd FileType text setlocal tw=80
    augroup END

    " Clean whitespace before saving: Python, C, HTML, and Objective-C
    augroup StripTrailingWhitespace
        autocmd!
        autocmd FileType python call <SID>strip_trailing_whitespace()
        autocmd FileType c,cpp,objc,objcpp call <SID>strip_trailing_whitespace()
        autocmd FileType html,css call <SID>strip_trailing_whitespace()
    augroup END

    " Indent wrapped long lines of code to leading indent
    augroup WrapLongLinesWithProperIndentation
        autocmd!
        autocmd FileType python,c,cpp,objc,objcpp,html,css setlocal breakindent showbreak=\ \ \ \ 
    augroup END

    augroup SConsFileType
        autocmd!
        autocmd BufRead SCons{truct,cript} setf python
    augroup END

    " Toggle position highlighting
    augroup HighlightCursorLineInNormalMode
        autocmd!
        autocmd InsertEnter * setlocal nocursorline
        autocmd InsertLeave * setlocal cursorline
    augroup END

    augroup XCodeProjectFileType
        autocmd!
        autocmd BufRead *.pbxproj setf xcodepbx
    augroup END
endif
" }}}

if has('unix')
    if filereadable($HOME."/.vimrc.local")
        source $HOME/.vimrc.local
    endif
endif
