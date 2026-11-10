" No plugin manager on purpose: this is the $EDITOR for commit messages, quick
" config edits and remote shells, so it must work from a bare checkout.

set nocompatible
filetype plugin indent on
syntax enable

" ------ interface ------
set number
set relativenumber
set ruler
set showcmd
set laststatus=2
set scrolloff=5
set sidescrolloff=5
set signcolumn=yes
set nowrap
set cursorline
set termguicolors
set background=dark

" ------ editing ------
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smartindent
set backspace=indent,eol,start
set nojoinspaces

" go and make want real tabs
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType make setlocal noexpandtab

" yaml/terraform/hcl are two-space by convention (already the default above,
" but pin them so a modeline elsewhere cannot drift)
autocmd FileType yaml,terraform,hcl setlocal expandtab tabstop=2 shiftwidth=2

" ------ search ------
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" ------ files ------
set encoding=utf-8
set fileformats=unix,dos
set autoread
set hidden
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undo//
silent! call mkdir(expand('~/.vim/undo'), 'p', 0700)

" ------ completion / command line ------
set wildmenu
set wildmode=longest:full,full
set wildignore+=*/.git/*,*/node_modules/*,*/.terraform/*
set completeopt=menuone,longest
set updatetime=300
set timeoutlen=500

" ------ clipboard ------
set clipboard=unnamed

" ------ leader mappings ------
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :Explore<CR>

" restore cursor position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g`\"" | endif

" never leave trailing whitespace behind in files we edit
autocmd BufWritePre *.zsh,*.sh,*.yaml,*.yml,*.tf,*.go,*.md :%s/\s\+$//e
