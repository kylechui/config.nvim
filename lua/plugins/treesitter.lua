return {
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.9.1",
        event = "BufRead",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            {
                "windwp/nvim-ts-autotag",
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
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "haskell",
                    "java",
                    "javascript",
                    "latex",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "nix",
                    "ocaml",
                    "python",
                    "query",
                    "typescript",
                    "vim",
                    "vimdoc",
                },
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
        "Wansmer/treesj",
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
