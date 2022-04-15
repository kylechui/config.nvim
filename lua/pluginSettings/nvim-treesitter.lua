require("nvim-treesitter.configs").setup({
    context_commentstring = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex" },
        custom_captures = {
            -- ["punctuation.delimiter"] = "TSInclude",
            -- ["punctuation.special"] = "TSInclude",
        },
    },
    playground = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
            },
        },
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
