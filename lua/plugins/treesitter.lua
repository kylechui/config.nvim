return {
    {
        [1] = "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                [1] = "JoosepAlviste/nvim-ts-context-commentstring",
                config = function()
                    vim.g.skip_ts_context_commentstring_module = true
                    require("ts_context_commentstring").setup({
                        enable_autocmd = false,
                    })
                end,
            },
            {
                [1] = "windwp/nvim-ts-autotag",
                ft = {
                    "html",
                    "xml",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "markdown",
                },
            },
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                autotag = {
                    enable = true,
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { "latex" },
                    additional_vim_regex_highlighting = { "latex" },
                },
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "bufwrite", "cursorHold" },
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["ac"] = "@comment.outer",
                            ["af"] = "@call.outer",
                            ["if"] = "@call.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<Leader>;"] = "@swappable",
                        },
                        swap_previous = {
                            ["<Leader>,"] = "@swappable",
                        },
                    },
                },
            })
        end,
    },
    {
        [1] = "Wansmer/treesj",
        keys = {
            {
                "gJ",
                function()
                    require("treesj").toggle()
                end,
            },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
}
