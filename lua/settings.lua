-- Define macros
local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.clipboard='unnamedplus'
o.modelines=0
o.maxmempattern=2500
-- For some reason you need to set tab options both globally and locally
o.expandtab=true
o.tabstop=4
o.softtabstop=4
o.shiftwidth=4
bo.expandtab=true
bo.tabstop=4
bo.softtabstop=4
bo.shiftwidth=4
o.mouse='n'
-- gui stuff
vim.cmd('colorscheme gruvbox-material')
o.guifont='FiraCode Nerd Font:h16'
vim.g.neovide_cursor_animation_length=0.1
vim.g.neovide_cursor_animate_in_insert_mode=0
o.number=true
o.relativenumber=true
o.wrap=true
o.cursorline=true
o.breakindent=true
o.linebreak=true
wo.number=true
wo.relativenumber=true
wo.wrap=true
wo.cursorline=true
wo.breakindent=true
wo.linebreak=true
o.scrolloff=8
o.termguicolors=true
o.hlsearch=false
o.incsearch=true
o.lazyredraw=true
o.inccommand='nosplit' -- Genius
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
