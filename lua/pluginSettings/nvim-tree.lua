local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_gitignore=1

require'bufferline'.setup{}
require'nvim-tree'.setup{
    follow = 1,
    view = {
        width = 36,
        mappings = {
            list = {
                { key = { '.' },      cb = tree_cb('toggle_dotfiles') },
                { key = { 'n' },      cb = tree_cb('create') },
                { key = { 'r' },      cb = tree_cb('full_rename') },
                { key = { '<' },      cb = tree_cb('dir_up') },
                { key = { '<C-r>' },  cb = tree_cb('refresh') },
            }
        }
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    }
}

vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged  = '',
        staged    = '',
        unmerged  = '',
        renamed   = '',
        untracked = '?',
        deleted   = '',
        ignored   = ''
    },
    folder_icons = {
        default      = '',
        open         = '',
        empty        = '',
        empty_open   = '',
        symlink      = '',
        symlink_open = '',
    },
    lsp = {
        hint    = '',
        info    = '',
        warning = '',
        error   = '',
    }
}
