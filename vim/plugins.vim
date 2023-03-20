" Eryn Wells <eryn@erynwells.me>

" Set up Vim and Neovim plugins with vim-plug.
" See setup.sh in my dotfiles repo for the setup procedure.

call plug#begin()

" Filetypes
Plug 'keith/swift.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'

" Editing helpers
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'PeterRincker/vim-argumentative'

" Environment niceties
Plug 'scrooloose/nerdtree'
if has('nvim')
    Plug 'Mofiqul/dracula.nvim'
endif

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
