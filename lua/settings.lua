-- I'm lazy
local opt = vim.opt

-- Define workspace path
vim.env.WORKSPACE = "~/Documents/github/"

-- Set Neovim to use the system clipboard
opt.clipboard = "unnamedplus"
-- Some execution-related settings
opt.modelines = 0
opt.maxmempattern = 2500
-- Setup colorscheme
vim.g.colors_name = "kanagawa"
opt.background = "dark"
opt.termguicolors = true
-- Set font for GUIs (I use Neovide)
opt.guifont = "JetBrains Mono:h12"
-- Allow mouse use in all modes
opt.mouse = "a"
-- Line number settings
opt.number = true
opt.relativenumber = true
-- Set cursor line settings
opt.wrap = true
opt.cursorline = true
opt.breakindent = true
opt.linebreak = true
-- Always show the sign column
opt.signcolumn = "yes"
-- Add a color column at 80 characters
opt.colorcolumn = "80"
-- Always show 8 lines of "context" above and below the cursor
opt.scrolloff = 8
-- Configure tab settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
-- Only save information about the cursor and folds on exit
opt.viewoptions = { "cursor", "folds" }
-- Setup smarter search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
-- Use global statusline
opt.laststatus = 3
-- Redraw the screen less during computationally intensive tasks
opt.lazyredraw = true
-- Force vertical splits to always open on the right
opt.splitright = true
opt.completeopt = { "menu", "menuone", "noselect" }
-- Neovide-specific cursor settings
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_animate_in_insert_mode = 0
-- Use filetype.lua instead of filetype.vim (faster startup)
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Adds a new command to reload snippets
vim.api.nvim_create_user_command("ReloadSnippets", function()
    require("luasnip.loaders.from_lua").load({
        paths = vim.fn["stdpath"]("config") .. "/luasnippets/"
    })
end, {})
