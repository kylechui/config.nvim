return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    keys = { "<Leader>f", "<Leader>s" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        [""] = { "<C-S-w>", type = "command" },
                    },
                    n = {
                        ["q"] = require("telescope.actions").close,
                    },
                },
                prompt_prefix = " λ ",
                -- selection_caret = " > ",
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

        -- Keybinds for editing init files
        vim.keymap.set("n", "<Leader>s", function()
            require("telescope.builtin").find_files({
                prompt_title = "Configuration files",
                cwd = vim.fn["stdpath"]("config"),
                file_ignore_patterns = { ".png" },
            })
        end, { silent = true })
        -- Telescope fuzzy find stuff
        vim.keymap.set("n", "<Leader>f.", require("telescope.builtin").find_files, { silent = true })
        vim.keymap.set("n", "<Leader>fb", function()
            require("telescope.builtin").find_files({
                prompt_title = "Books",
                cwd = vim.env.BOOKS,
            })
        end, { silent = true })
        vim.keymap.set("n", "<Leader>ff", function()
            require("telescope.builtin").find_files({
                prompt_title = "Workspace files",
                cwd = vim.env.WORKSPACE,
                file_ignore_patterns = {
                    -- TeX temporary files
                    "%.aux",
                    "%.bbl",
                    "%.bcf",
                    "%.blg",
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
                    -- Non-text files
                    "%.png",
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
                    -- Web development files
                    "node_modules/",
                },
            })
        end, { silent = true })
        vim.keymap.set("n", "<Leader>fg", require("telescope.builtin").live_grep, { silent = true })
        vim.keymap.set("n", "<Leader>fh", require("telescope.builtin").help_tags, { silent = true })
        require("telescope").load_extension("fzf")
    end,
}
