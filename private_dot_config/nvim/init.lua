--local utils = require('utils')
local map = vim.api.nvim_set_keymap
local set = vim.opt

-----------------------------------------------------------------------
-- options
-----------------------------------------------------------------------
vim.g.mapleader = ','
vim.g['sneak#label'] = 1

set.history = 500

-- autoread when file changed from outside
set.autoread = true
vim.cmd('au FocusGained,BufEnter * checktime')

-- Return to last edit position when opening files (You want this!)
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

set.so = 7

set.wildmenu = true
set.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
]]

set.ruler = true
set.cmdheight = 1
set.hidden = true

-- Configure backspace so it acts as it should act
set.backspace = "eol,start,indent"
set.whichwrap = "<,>,h,l"

set.ignorecase = true -- Ignore case when searching
set.smartcase = true-- When searching try to be smart about cases 
set.hlsearch = true-- Highlight search results
set.incsearch = true-- Makes search act like search in modern browsers

set.lazyredraw = true -- Don't redraw while executing macros (good performance config)

set.showmatch = true -- Show matching brackets when text indicator is over them
set.matchtime = 2 -- How many tenths of a second to blink when matching brackets

-- No annoying sound on errors
set.errorbells = false
set.visualbell = false
set.timeoutlen = 500

set.showmode = false -- required for statusline plugin

set.mouse = "nv"

-- hybrid relative numbers
set.number = true
set.relativenumber = true

set.foldcolumn = "1"

set.expandtab = true -- Use spaces instead of tabs
set.smarttab = true -- Be smart when using tabs ;)

-- 1 tab == 4 spaces
set.shiftwidth = 4
set.tabstop = 4

set.ai = true-- Auto indent
set.si = true-- "Smart indent
set.wrap = true-- "Wrap lines

set.foldmethod = "syntax" -- Preferred foldmethod
-----------------------------------------------------------------------
-- keymaps
-----------------------------------------------------------------------
opts = { noremap = true }

-- Fast saving
map('n', '<leader>w', '<cmd>w!<cr>', {})

-- Map Space to (search) and ^Space to (backwards search)
map('', '<space>', '/', opts)
map('', '<C-space>', '?', opts)

-- Disable highlight when pressed
map('', '<leader><cr>', '<cmd>noh<cr><cmd>call sneak#cancel()<cr>', { noremap = true, silent = true })

-- Tab navigation
map('n', 'H', 'gT', opts)
map('n', 'L', 'gt', opts)

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', opts)
map('n', '<C-j>', '<C-w><C-j>', opts)
map('n', '<C-k>', '<C-w><C-k>', opts)
map('n', '<C-l>', '<C-w><C-l>', opts)

-- FzfLua bindings
map('n', '<C-f>', "<cmd>lua require('fzf-lua').files()<CR>", opts)
map('n', '<C-g>', "<cmd>lua require('fzf-lua').git_files()<CR>", opts)

-- Sneak mappings
map('n', 'f', '<Plug>Sneak_s', {})
map('n', 'F', '<Plug>Sneak_S', {})
-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------
local plug_dir = vim.fn.stdpath('data') .. '/plugged'
vim.fn['plug#begin'](plug_dir)

vim.cmd([[
Plug 'tpope/vim-fugitive'

Plug 'rust-lang/rust.vim'

Plug 'ibhagwan/fzf-lua'
Plug 'vijaymarupudi/nvim-fzf'

Plug 'nvim-lualine/lualine.nvim'

Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'

" Lsp support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'justinmk/vim-sneak'
]])

vim.fn['plug#end']()
-----------------------------------------------------------------------
-- Colours
-----------------------------------------------------------------------
set.termguicolors = true
vim.cmd('syntax on')
vim.cmd('colorscheme onedark')

vim.g.sonokai_style = 'atlantis'
-- vim.cmd('colorscheme sonokai')
-----------------------------------------------------------------------
-- Modules
-----------------------------------------------------------------------
require('lsp')
require('cmp_config')
require('nvim-tree').setup{}

require('lualine').setup{
    options = {
        theme = onedark,
        -- theme = sonokai
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            }
        }
    }
}
