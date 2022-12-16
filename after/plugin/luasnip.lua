local ok, ls = pcall(require, "luasnip")
if not ok then
    print("Failed to load LuaSnip")
    return
end

local types = require("luasnip.util.types")

-- Loads in snippets
require("luasnip.loaders.from_lua").load({
    paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
})

ls.config.set_config({
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
