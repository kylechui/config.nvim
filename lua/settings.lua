-- I'm lazy
local opt = vim.opt

opt.clipboard='unnamedplus'
opt.modelines=0
opt.maxmempattern=2500
-- gui stuff
vim.cmd('colorscheme gruvbox-material')
opt.guifont='FiraCode NF:h16'
opt.termguicolors=true
opt.mouse='n'
opt.number=true
opt.relativenumber=true
opt.wrap=true
opt.cursorline=true
opt.breakindent=true
opt.linebreak=true
opt.scrolloff=8

opt.lazyredraw=true
opt.hlsearch=false
opt.incsearch=true
opt.inccommand='nosplit'
-- Neovide specific settings
vim.g.neovide_cursor_animation_length=0.1
vim.g.neovide_cursor_animate_in_insert_mode=0
-- Highlight yanked text
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Visual", timeout=300}
augroup END
]])
-- Some settings for files with more prose
vim.cmd([[
augroup writingStuff
    autocmd!
    autocmd FileType text,tex,md setlocal spell
    autocmd FileType text,tex,md set spelllang=en_gb
    autocmd FileType text,tex,md set tabstop=2
    autocmd FileType text,tex,md set softtabstop=2
    autocmd FileType text,tex,md set shiftwidth=2
    autocmd FileType text,md set textwidth=80
augroup END
]])
