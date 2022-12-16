local map = vim.keymap.set
-- Set up <Space> to be the global leader
vim.g.mapleader = " "
-- Keybinds for editing init files
map("n", "<Leader>s", require("plugin.telescope").search_dotfiles, { silent = true })
-- Saving files with <C-s>
map("n", "<C-s>", vim.cmd.update, { silent = true })
map({ "i", "x" }, "<C-s>", "<Esc><Cmd>up!<CR>", { silent = true })
-- Deleting words with <C-BS>
map({ "c", "i" }, "<C-BS>", "<C-w>", {})
-- Toggle file explorer and focus on the open file
map("n", "<C-Bslash>", function()
    require("nvim-tree").toggle(true)
end, { silent = true })
-- Move towards the beginning/end of a line
map({ "n", "x" }, "H", "g^", { silent = true })
map({ "n", "x" }, "L", "g$", { silent = true })
-- Better indent/dedent lines and blocks of text
map("n", ">", ">>", { silent = true })
map("n", "<", "<<", { silent = true })
map("x", ">", ">gv", { silent = true })
map("x", "<", "<gv", { silent = true })
-- Better buffer navigation/deletion
map("n", "<Leader>j", function()
    require("bufferline").cycle(1)
end, { silent = true })
map("n", "<Leader>k", function()
    require("bufferline").cycle(-1)
end, { silent = true })
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("n", "<C-w>", "<Cmd>bd!<CR>", { silent = true })
map("n", "<A-h>", function()
    require("bufferline").move(-1)
end, { silent = true })
map("n", "<A-l>", function()
    require("bufferline").move(1)
end, { silent = true })
-- Telescope fuzzy find stuff
map("n", "<Leader>f.", require("telescope.builtin").find_files, { silent = true })
map("n", "<Leader>fb", require("plugin.telescope").search_books, { silent = true })
map("n", "<Leader>ff", require("plugin.telescope").search_workspace, { silent = true })
map("n", "<Leader>fg", require("telescope.builtin").live_grep, { silent = true })
map("n", "<Leader>fh", require("telescope.builtin").help_tags, { silent = true })
-- Navigate by wrapped lines by default
map({ "n", "x" }, "j", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"', { silent = true, expr = true })
map({ "n", "x" }, "k", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"', { silent = true, expr = true })
-- Universal comments with <C-/>
map("n", "<C-/>", "<Cmd>norm gcc<CR>")
map("x", "<C-/>", "<Cmd>norm gbgv<CR>")
-- Allow for repeating commands in visual mode
map("x", ".", ":normal.<CR>", { silent = true })
-- Better deletion of visual selections
map("x", "<Leader>p", '"_dP', { silent = true })
-- Spell check
map("i", "<C-l>", "<C-g>u<ESC>b[s1z=`]a<C-g>u", { silent = true })
-- Git binds
map("n", "<Leader>g", "<Cmd>Git<CR>")
map("n", "<Leader>gp", "<Cmd>Git push<CR>")
-- Font size adjustment
map("n", "<C-=>", function()
    require("utils").adjust_font_size(1)
end)
map("n", "<C-->", function()
    require("utils").adjust_font_size(-1)
end)
-- LSP nonsense
map("n", "gD", vim.lsp.buf.declaration, { silent = true })
map("n", "gd", vim.lsp.buf.definition, { silent = true })
map("n", "K", vim.lsp.buf.hover, { silent = true })
-- Select all
map("n", "<C-a>", "ggVG", { silent = true })
map("i", "<C-a>", "<Esc>ggVG", { silent = true })
-- Disable ex mode
map("n", "Q", "<NOP>", { silent = true })
-- Map esc to go to normal mode for terminal
map("t", "<Esc>", "<C-\\><C-n>", { silent = true })
-- Map <C-j> and <C-k> to scroll up and down autocompletion list in command mode
map("c", "<C-j>", "<C-n>", { remap = true, silent = true })
map("c", "<C-k>", "<C-p>", { remap = true, silent = true })
-- Reverse join lines
map("n", "gJ", require("trevj").format_at_cursor, { silent = true })
-- Smart delete lines; don't clutter clipboard with whitespace lines
map("n", "dd", function()
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, { expr = true, silent = true })

local ls = require("luasnip")
map({ "i", "s" }, "<Tab>", function()
    if ls.expand_or_jumpable() then
        return "<Plug>luasnip-expand-or-jump"
    else
        return "<Tab>"
    end
end, { expr = true })

map({ "i", "s" }, "<S-Tab>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

map({ "i", "s" }, "<C-j>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

map({ "i", "s" }, "<C-k>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end, { silent = true })

-- Custom operator-mode mappings for easier surrounds
map("o", "ar", "a[")
map("o", "ir", "i[")
map("o", "aa", "a<")
map("o", "ia", "i<")
