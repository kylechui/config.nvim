return {
    ---[=[
    {
        -- dir = "/home/kylec/Documents/github/nvim-surround/add-tag-query",
        dir = "/home/kylec/Documents/github/nvim-surround/main",
        event = "VeryLazy",
        config = function()
            vim.cmd.highlight("default link NvimSurroundHighlight Todo")
            require("nvim-surround").setup({
                --[[ surrounds = {
                ["t"] = {
                    delete = function()
                        return require("nvim-surround.config").get_selections({
                            char = "t",
                            exclude = function()
                                return require("nvim-surround.config").get_selection({
                                    query = {
                                        capture = "@tag.content",
                                        type = "nvim-surround",
                                    },
                                })
                            end,
                        })
                    end,
                },
            }, ]]
            })
        end,
    },
    --]=]
    -- "tpope/vim-surround",
}
