local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    print("Failed to load nvim-tree")
    return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback

nvim_tree.setup({
    view = {
        width = 36,
        mappings = {
            list = {
                { key = { "." }, cb = tree_cb("toggle_dotfiles") },
                { key = { "n" }, cb = tree_cb("create") },
                { key = { "r" }, cb = tree_cb("full_rename") },
                { key = { "<" }, cb = tree_cb("dir_up") },
                { key = { "<C-r>" }, cb = tree_cb("refresh") },
            },
        },
    },
})

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "",
        untracked = "?",
        deleted = "",
        ignored = "",
    },
    folder_icons = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
}
