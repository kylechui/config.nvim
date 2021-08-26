local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    }
  },
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('fzf')

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
    file_ignore_patterns = { '.docx' },
  })
end
return M
