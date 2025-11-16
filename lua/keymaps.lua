local map = vim.keymap.set
-- Quitting Neovim
map("n", "<Leader>qq", "<Cmd>qall<CR>", { silent = true })
-- Saving files with <C-s>
map("n", "<C-s>", vim.cmd.update, { silent = true })
map({ "i", "x" }, "<C-s>", "<Esc><Cmd>up!<CR>", { silent = true })
-- Deleting words with <C-BS>
map({ "c", "i" }, "<C-BS>", "<C-w>")
map({ "c", "i" }, "", "<C-w>")
-- Move towards the beginning/end of a line
map({ "n", "x" }, "H", "g^", { silent = true })
map({ "n", "x" }, "L", "g$", { silent = true })
-- Better indent/dedent lines and blocks of text
map("n", ">", ">>", { silent = true })
map("n", "<", "<<", { silent = true })
map("x", ">", ">gv", { silent = true })
map("x", "<", "<gv", { silent = true })
-- Better window management
map("n", "<Leader>wh", "<C-w>h", { silent = true })
map("n", "<Leader>wj", "<C-w>j", { silent = true })
map("n", "<Leader>wk", "<C-w>k", { silent = true })
map("n", "<Leader>wl", "<C-w>l", { silent = true })
map("n", "<Leader>wH", "<C-w>H", { silent = true })
map("n", "<Leader>wJ", "<C-w>J", { silent = true })
map("n", "<Leader>wK", "<C-w>K", { silent = true })
map("n", "<Leader>wL", "<C-w>L", { silent = true })
map("n", "<Leader>wd", vim.cmd.close, { silent = true })
map("n", "<Leader>wx", "<Cmd>bd!<CR>", { silent = true })
map("n", "<Leader>w=", "<Cmd>wincmd =<CR>", { silent = true })
-- Better buffer navigation/deletion
map("n", "<Leader><Tab>", "<C-^>", { silent = true })
map("n", "<Leader>bd", function()
    -- Switch to alternate buffer, then delete the original buffer to preserve window layout
    vim.cmd("buffer #")
    vim.cmd("bdelete #")
end, { silent = true })
map("n", "<Leader>bx", "<Cmd>bd!<CR>", { silent = true })
-- Navigating through quickfix list
map("n", "<Leader>qfn", "<Cmd>cnext<CR>", { silent = true })
map("n", "<Leader>qfp", "<Cmd>cprev<CR>", { silent = true })
-- Navigate by wrapped lines by default
map({ "n", "x" }, "j", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"', { silent = true, expr = true })
map({ "n", "x" }, "k", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"', { silent = true, expr = true })
-- Allow for repeating commands in visual mode
map("x", ".", ":normal.<CR>", { silent = true })
-- Better deletion of visual selections
map("x", "<Leader>p", '"_dP', { silent = true })
-- Quit all buffers
map("n", "<Leader>qq", "<Cmd>qall<CR>", { silent = true })
-- Spell check
map("i", "<C-l>", "<C-g>u<ESC>[s1z=`]a<C-g>u", { silent = true })
-- Font size adjustment
map("n", "<C-=>", function()
    require("utils").adjust_font_size(1)
end)
map("n", "<C-->", function()
    require("utils").adjust_font_size(-1)
end)
-- Select all
map("n", "<C-a>", "ggVG", { silent = true })
map("i", "<C-a>", "<Esc>ggVG", { silent = true })
-- Repeat last macro
map("n", "Q", "@@", { silent = true })
-- Map esc to go to normal mode for terminal
map("t", "<Esc>", "<C-Bslash><C-n>", { silent = true })
-- Map <C-j> and <C-k> to scroll up and down autocompletion list in command mode
map("c", "<C-j>", "<C-n>", { remap = true, silent = true })
map("c", "<C-k>", "<C-p>", { remap = true, silent = true })
-- Smart delete lines; don't clutter clipboard with whitespace lines
map("n", "dd", function()
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, { expr = true, silent = true })
-- Custom operator-mode mappings for easier surrounds
map({ "o", "x" }, "ar", "a[")
map({ "o", "x" }, "ir", "i[")
map({ "o", "x" }, "aa", "a<")
map({ "o", "x" }, "ia", "i<")
