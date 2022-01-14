local actions = require('telescope.actions')
local fb_actions = require('telescope').extensions.file_browser.actions

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                -- ['<CR>'] = actions.select_default,
            },
        },
    },
    extensions = {
        file_browser = {
            mappings = {
                i = {
                    -- ['<CR>'] = fb_actions.open,
                },
            },
        },
    },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

local M = {}
M.search_dotfiles = function()
    require('telescope.builtin').find_files({
        prompt_title = 'Configuration files',
        cwd = vim.fn['stdpath']('config'),
        file_ignore_patterns = { '.png' },
    })
end

M.search_workspace = function()
    require('telescope.builtin').find_files({
        prompt_title = 'Workspace files',
        cwd = vim.env.WORKSPACE,
        file_ignore_patterns = {
            -- TeX temporary files
            '%.aux',
            '%.fdb_latexmk',
            '%.fls',
            '%.log',
            '%.pdf_tex',
            '%.synctex.gz',
            '%.ttf',
            '%.xdv',
            -- C++ temporary files
            '%.o',
            '%.out',
            -- Git related files and directories
            'description',
            'packed%-refs',
            'HEAD',
            'hooks/',
            'objects/',
            'refs/',
            'info/',
            'logs/',
            'worktrees/',
        },
    })
end

M.search_folders = function()
    require('telescope').extensions.file_browser.file_browser({
        cwd = vim.env.WORKSPACE,
        depth = false,
        files = false,
    })
end
return M
