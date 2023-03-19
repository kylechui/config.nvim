return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
        local types = require("luasnip.util.types")

        -- Loads in snippets
        require("luasnip.loaders.from_lua").load({
            paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
        })
        -- Adds a new command to reload snippets
        vim.api.nvim_create_user_command("ReloadSnippets", function()
            require("luasnip.loaders.from_lua").load({
                paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
            })
        end, {})

        require("luasnip").config.set_config({
            update_events = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "<- Choice" } },
                    },
                },
            },
        })
    end,
}
