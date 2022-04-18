-- I'm lazy
local opt = vim.opt

-- Define workspace path
vim.env.WORKSPACE = "~/Documents/github/"

opt.clipboard = "unnamedplus"
opt.modelines = 0
opt.maxmempattern = 2500
-- GUI stuff
vim.cmd("colorscheme kanagawa")

opt.guifont = "JetBrains Mono:h12"
opt.termguicolors = true
opt.mouse = "a"
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
opt.viewoptions = "folds,cursor"
opt.ignorecase = true
opt.smartcase = true
opt.colorcolumn = "80"
opt.laststatus = 3

opt.lazyredraw = true
opt.hlsearch = false
opt.splitright = true
opt.completeopt = "menu,menuone,noselect"
-- Neovide-specific cursor settings
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_animate_in_insert_mode = 0
-- Use filetype.lua instead of filetype.vim (faster startup)
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Adds a new command to reload snippets
vim.api.nvim_create_user_command("ReloadSnippets", [[
    lua require("luasnip.loaders.from_lua").load({
        paths = vim.fn["stdpath"]("config") .. "/luasnippets/"
    })
]], {})
