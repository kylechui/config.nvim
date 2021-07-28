require'bufferline'.setup{}
vim.g.nvim_tree_width=36
vim.g.nvim_tree_follow=1
vim.g.nvim_tree_gitignore=1
-- vim.g.nvim_tree_root_folder_modifier=':.'
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
    { key = { "." },      cb = tree_cb("toggle_dotfiles") },
    { key = { "n" },      cb = tree_cb("create") },
    { key = { "r" },      cb = tree_cb("full_rename") },
    { key = { "<" },      cb = tree_cb("dir_up") },
    { key = { "<C-r>" },  cb = tree_cb("refresh") },
} 

vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged  = "",
        staged    = "",
        unmerged  = "",
        renamed   = "",
        untracked = "?",
        deleted   = "",
        ignored   = ""
    },
    folder_icons = {
        default      = "",
        open         = "",
        empty        = "",
        empty_open   = "",
        symlink      = "",
        symlink_open = "",
    },
    lsp = {
        hint    = "",
        info    = "",
        warning = "",
        error   = "",
    }
}
