-- I'm lazy
local opt = vim.opt
local g = vim.g

-- Define environment variables
vim.env.BOOKS = "~/Documents/Books/"
vim.env.WORKSPACE = "~/Documents/github/"
vim.env.OBSIDIAN_VAULT = "~/Documents/github/obelisk"

-- Set Neovim to use the system clipboard
opt.clipboard = "unnamedplus"
-- Some execution-related settings
opt.modelines = 0
opt.maxmempattern = 2500
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
g.neovide_cursor_animation_length = 0.05
g.neovide_cursor_animate_in_insert_mode = 0

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
