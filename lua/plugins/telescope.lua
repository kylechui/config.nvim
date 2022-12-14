local ok, telescope = pcall(require, "telescope")
if not ok then
    print("Failed to load telescope.nvim")
    return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
                ["q"] = require("telescope.actions").close,
            },
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.6,
                results_width = 0.25,
            },
            vertical = {
                mirror = false,
            },
            width = 0.85,
            height = 0.85,
            preview_cutoff = 60,
        },
        border = {},
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

M.search_books = function()
    builtin.find_files({
        prompt_title = "Books",
        cwd = vim.env.BOOKS,
    })
end

return M
