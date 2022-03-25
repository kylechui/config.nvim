local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

telescope.load_extension("fzf")

local M = {}

M.search_dotfiles = function()
	builtin.find_files({
		prompt_title = "Configuration files",
		cwd = vim.fn["stdpath"]("config"),
		file_ignore_patterns = { ".png" },
	})
end

M.search_workspace = function()
	builtin.find_files({
		prompt_title = "Workspace files",
		cwd = vim.env.WORKSPACE,
		file_ignore_patterns = {
			-- TeX temporary files
			"%.aux",
			"%.fdb_latexmk",
			"%.fls",
			"%.log",
			"%.pdf_tex",
			"%.synctex.gz",
			"%.ttf",
			"%.xdv",
			-- C++ temporary files
			"%.o",
			"%.out",
			-- Git related files and directories
			"description",
			"packed%-refs",
			"HEAD",
			"hooks/",
			"objects/",
			"refs/",
			"info/",
			"logs/",
			"worktrees/",
		},
	})
end

return M
