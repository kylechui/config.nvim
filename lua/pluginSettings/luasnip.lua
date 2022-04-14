local ls = require("luasnip")
local types = require("luasnip.util.types")

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
