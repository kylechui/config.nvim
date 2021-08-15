-- I'm lazy
local opt = vim.opt

opt.clipboard='unnamedplus'
opt.modelines=0
opt.maxmempattern=2500
-- gui stuff
vim.cmd('colorscheme gruvbox-flat')
vim.g.gruvbox_flat_style='dark'
opt.guifont='FiraCode Nerd Font Mono:h16'
opt.termguicolors=true
opt.mouse='n'
opt.number=true
opt.relativenumber=true
opt.wrap=true
opt.cursorline=true
opt.breakindent=true
opt.linebreak=true
opt.scrolloff=8
opt.tabstop=2
opt.softtabstop=2
opt.shiftwidth=2
opt.expandtab=true
opt.shiftround=true

opt.lazyredraw=true
opt.hlsearch=false
opt.incsearch=true
opt.inccommand='nosplit'
opt.splitright=true
-- Neovide specific settings
vim.cmd([[
let g:neovide_cursor_animation_length=0.05
let g:neovide_cursor_animate_in_insert_mode=0
]])
-- Highlight yanked text
vim.cmd([[
augroup highlightYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="Visual", timeout=300}
augroup END
]])
-- Some settings for files with more prose
vim.cmd([[
augroup writingStuff
    autocmd!
    autocmd FileType text,tex,md setlocal spell
    autocmd FileType text,tex,md set tabstop=2
    autocmd FileType text,tex,md set softtabstop=2
    autocmd FileType text,tex,md set shiftwidth=2
    autocmd FileType text,md set textwidth=80
augroup END
]])
-- Autocommands for compiling/running C++ files
vim.cmd([[
augroup cppCommands
    autocmd!
    autocmd FileType cpp nnoremap <C-'> <Cmd>term g++ -o %:r.out % -std=c++11 && ./%:r.out<CR>
augroup END
]])
