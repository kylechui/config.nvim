local map = vim.keymap.set
-- Set up <Space> to be the global leader
map("n", "<Space>", "<NOP>", { silent = true })
vim.g.mapleader = " "
-- Keybinds for editing init files
map("n", "<Leader>s", require("pluginSettings.telescope").search_dotfiles, { silent = true })
-- Edit snippets
map("n", "<Leader>u", "<Cmd>UltiSnipsEdit<CR>", { silent = true })
-- Saving files with <C-s>
map("n", "<C-s>", "<Cmd>up!<CR>", { silent = true })
map("i", "<C-s>", "<Esc><Cmd>up!<CR>", { silent = true })
map("x", "<C-s>", "<Esc><Cmd>up!<CR>", { silent = true })
-- Deleting words with <C-BS>
map("i", "", "<C-w>", { silent = true })
map("c", "", "<C-w>", { silent = true })
map("i", "<C-BS>", "<C-w>", { silent = true })
map("c", "<C-BS>", "<C-w>", { silent = true })
-- Open/close file explorer
map("n", "<C-\\>", "<Cmd>NvimTreeToggle<CR>", { silent = true })
-- Move towards the beginning/end of a line
map("n", "H", "g^", { silent = true })
map("x", "H", "g^", { silent = true })
map("n", "L", "g$", { silent = true })
map("x", "L", "g$", { silent = true })
-- Better indent/dedent lines and blocks of text
map("n", ">", ">>", { silent = true })
map("n", "<", "<<", { silent = true })
map("x", ">", ">gv", { silent = true })
map("x", "<", "<gv", { silent = true })
-- Better buffer navigation/deletion
map("n", "<Leader>j", "<Cmd>bn<CR>", { silent = true })
map("n", "<Leader>k", "<Cmd>bp<CR>", { silent = true })
map("n", "<C-Tab>", "<Cmd>bn<CR>", { silent = true })
map("n", "<C-S-Tab>", "<Cmd>bp<CR>", { silent = true })
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("n", "<C-w>", "<Cmd>bd!<CR>", { silent = true })
map("i", "<C-w>", "<Cmd>bd!<CR>", { silent = true })
map("n", "<A-h>", "<Cmd>BufferLineMovePrev<CR>", { silent = true })
map("n", "<A-l>", "<Cmd>BufferLineMoveNext<CR>", { silent = true })
-- Telescope fuzzy find stuff
map("n", "<Leader>f.", require("telescope.builtin").find_files, { silent = true })
map("n", "<Leader>ff", require("pluginSettings.telescope").search_workspace, { silent = true })
map("n", "<Leader>fg", require("telescope.builtin").live_grep, { silent = true })
map("n", "<Leader>fh", require("telescope.builtin").help_tags, { silent = true })
-- Navigate by wrapped lines by default
map("n", "j", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"', { silent = true, expr = true })
map("n", "k", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"', { silent = true, expr = true })
map("x", "j", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"', { silent = true, expr = true })
map("x", "k", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"', { silent = true, expr = true })
-- Universal comments with <C-/> (written as <C-_> to work in terminal)
map("n", "<C-/>", "gcc")
map("x", "<C-/>", "gbgv")
map("n", "<C-_>", "gcc")
map("x", "<C-_>", "gbgv")
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
map("n", "<C-=>", "<Cmd>lua require('utils').adjust_font_size(1)<CR>")
map("n", "<C-->", "<Cmd>lua require('utils').adjust_font_size(-1)<CR>")
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
map("c", "<C-j>", "<C-n>", { silent = true })
map("c", "<C-k>", "<C-p>", { silent = true })

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if ls.expand_or_jumpable() then
		return "<Plug>luasnip-expand-or-jump"
	else
		return "<Tab>"
	end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.choice_active() then
        ls.change_choice(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end, { silent = true })
