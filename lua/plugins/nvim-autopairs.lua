return {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
        require("nvim-autopairs").setup()

        -- Don't autopair ' when in a .tex file
        require("nvim-autopairs").get_rule("'")[1]:with_pair(function()
            if vim.bo.filetype == "tex" then
                return false
            end
        end)

        -- Don't autopair " when in a .tex file
        require("nvim-autopairs").get_rule('"')[1]:with_pair(function()
            if vim.bo.filetype == "tex" then
                return false
            end
        end)
    end,
}
