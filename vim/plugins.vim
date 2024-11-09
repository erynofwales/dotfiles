" Eryn Wells <eryn@erynwells.me>

" Set up Vim and Neovim plugins with vim-plug.
" See setup.sh in my dotfiles repo for the setup procedure.

call plug#begin()

" Filetypes
Plug 'keith/swift.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'tag': 'v1.28' }

" Editing helpers
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'PeterRincker/vim-argumentative'

" Environment niceties
Plug 'scrooloose/nerdtree'

if has('nvim')
    Plug 'Mofiqul/dracula.nvim'
endif

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'dracula/vim', {'as': 'dracula'}

if has('nvim')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'p00f/clangd_extensions.nvim'
endif

call plug#end()
