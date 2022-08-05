require("nvim-treesitter.configs").setup({
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex" },
    },
    playground = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
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
