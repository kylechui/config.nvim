-- I'm lazy
local opt = vim.opt

-- Define workspace path
vim.env.WORKSPACE = '~/Documents/github/'

opt.clipboard = 'unnamedplus'
opt.modelines = 0
opt.maxmempattern = 2500
-- GUI stuff
vim.g.gruvbox_flat_style = 'dark'
vim.cmd([[
    colorscheme gruvbox-flat
]])
-- vim.g.colors_name = 'gruvbox-flat'

opt.guifont = 'JetBrains Mono:h12'
opt.termguicolors = true
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.wrap = true
opt.cursorline = true
opt.breakindent = true
opt.linebreak = true
opt.scrolloff = 8
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
opt.viewoptions = 'folds,cursor'
opt.ignorecase = true
opt.smartcase = true
opt.colorcolumn = '80'

opt.lazyredraw = true
opt.hlsearch = false
opt.incsearch = true
opt.splitright = true
opt.completeopt='menu,menuone,noselect'
-- Neovide-specific cursor settings
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_animate_in_insert_mode = 0
-- Highlight yanked text
vim.cmd([[
augroup highlightYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup = 'Visual', timeout = 300}
augroup END
]])
-- Save/restore code folds
vim.cmd([[
augroup saveFolds
    autocmd!
    autocmd BufWinLeave ?* mkview
    autocmd BufWinEnter ?* silent! loadview
augroup END
]])
