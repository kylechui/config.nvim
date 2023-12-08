return {
    [1] = "L3MON4D3/LuaSnip",
    version = "^2.1.0",
    event = "InsertEnter",
    config = function()
        local types = require("luasnip.util.types")
        -- Loads in snippets
        require("luasnip.loaders.from_lua").load({
            paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
        })
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
