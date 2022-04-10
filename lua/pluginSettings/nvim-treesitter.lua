require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex" },
        custom_captures = {
            -- ["punctuation.delimiter"] = "TSInclude",
            -- ["punctuation.special"] = "TSInclude",
        },
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<Leader>;"] = "@parameter.inner",
            },
            swap_previous = {
                ["<Leader>,"] = "@parameter.inner",
            },
        },
    },
})
