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
        vim.keymap.set("n", "<Leader>f.", function()
            require("telescope.builtin").find_files({
                file_ignore_patterns = {
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
        end, { silent = true })
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
        vim.keymap.set("n", "<Leader>fd", function()
            local find_directory = function(opts)
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local action_state = require("telescope.actions.state")
                opts = opts or {}
                pickers
                    .new(opts, {
                        prompt_title = "Find Directory",
                        finder = finders.new_table({
                            results = vim.fs.find(function(name, path)
                                local full_path = path .. "/" .. name
                                local exclude = {
                                    "/%.",
                                    "/_",
                                    "/objects",
                                    "/refs",
                                    "/info",
                                    "/logs",
                                    "/worktrees",
                                    "/node_modules",
                                    "/__pycache__",
                                }
                                for _, pattern in pairs(exclude) do
                                    if full_path:match(pattern) then
                                        return false
                                    end
                                end
                                return true
                            end, {
                                limit = math.huge,
                                type = "directory",
                                path = vim.env.WORKSPACE,
                            }),
                        }),
                        sorter = conf.generic_sorter(opts),
                        attach_mappings = function(prompt_bufnr, map)
                            actions.select_default:replace(function()
                                actions.close(prompt_bufnr)
                                local selection = action_state.get_selected_entry()
                                require("nvim-tree.api").tree.toggle({
                                    path = selection[1]:gsub("~", vim.env.HOME),
                                })
                            end)
                            return true
                        end,
                    })
                    :find()
            end
            find_directory(require("telescope.themes").get_dropdown({}))
        end, { silent = true })
        vim.keymap.set("n", "<Leader>fo", function()
            require("telescope.builtin").find_files({
                prompt_title = "Obsidian Vault",
                cwd = vim.env.OBSIDIAN_VAULT,
            })
        end, { silent = true })
        require("telescope").load_extension("fzf")
    end,
}
