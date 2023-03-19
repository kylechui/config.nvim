return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
            "Wansmer/treesj",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "haskell",
                    "help",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "ocaml",
                    "python",
                    "query",
                    "vim",
                },
                highlight = {
                    enable = true,
                    disable = { "latex" },
                    additional_vim_regex_highlighting = { "latex" },
                },
                playground = {
                    enable = true,
                },
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite", "CursorHold" },
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["ac"] = "@comment.outer",
                            ["aF"] = "@function.outer",
                            ["iF"] = "@function.inner",
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
}
