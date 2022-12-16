local ok, cmp = pcall(require, "cmp")
if not ok then
    print("Failed to load nvim-cmp")
    return
end

local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<CR>"] = cmp.config.disable,
    }),
    sources = cmp.config.sources({
        --[[ { name = "nvim_lua" }, ]]
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 4 },
        { name = "luasnip" },
        { name = "dictionary", keyword_length = 4 },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                return vim_item
            end,
        }),
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

require("cmp_dictionary").setup({
    dic = {
        ["*"] = { "~/.config/nvim/spell/en.utf-8.add", "/usr/share/dict/words" },
    },
    first_case_insensitive = true,
})
