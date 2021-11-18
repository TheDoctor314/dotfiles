"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500

filetype plugin on
filetype indent on

let mapleader = ","

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" This automatically runs :Rustfmt on saving a buffer
let g:rustfmt_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7

set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set ruler
set cmdheight=1
set hid

" Turn hybrid line numbers on
set number relativenumber

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

set encoding=utf8

set noshowmode

set mouse=nv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" My fav foldmethod
set foldmethod=syntax

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around tabs, windows, buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map Space to (search) and ^Space to (backwards search) 
noremap <space> /
noremap <C-space> ?

" Disable highlight when this is pressed
noremap <silent> <leader><cr> :noh<cr>

" Tab navigation
nnoremap H gT
nnoremap L gt

" Window navigation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Mappings to quickly open files (provided by fzf)
nnoremap <C-g> :GFiles<cr>
nnoremap <C-f> :Files<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let g:sneak#label = 1
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
nnoremap <C-c> :call sneak#cancel()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin manager - vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive'

Plug 'rust-lang/rust.vim'

Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'

Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'

" Lsp support
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'justinmk/vim-sneak'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colours
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Copied from onedark's README.
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'component' : {
  \   'filename': '%f'
  \ },
  \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lua modules
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('lsp')
lua require('lspfuzzy').setup{}
lua require('cmp_config')
lua require('nvim-tree').setup{}
