local map = vim.keymap.set
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
-- Better buffer navigation/deletion
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("n", "<C-w>", "<Cmd>bd!<CR>", { silent = true })
-- Navigate by wrapped lines by default
map({ "n", "x" }, "j", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"', { silent = true, expr = true })
map({ "n", "x" }, "k", 'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"', { silent = true, expr = true })
-- Allow for repeating commands in visual mode
map("x", ".", ":normal.<CR>", { silent = true })
-- Better deletion of visual selections
map("x", "<Leader>p", '"_dP', { silent = true })
-- Open todo list
map("n", "<Leader>t", function()
    vim.cmd.edit("~/todo.md")
end, { silent = true })
-- Spell check
map("i", "<C-l>", "<C-g>u<ESC>b[s1z=`]a<C-g>u", { silent = true })
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
