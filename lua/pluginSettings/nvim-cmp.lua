-- Setup nvim-cmp
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(
            { behavior = cmp.SelectBehavior.Insert },
            { "i", "c" }
        ),
        ["<C-k>"] = cmp.mapping.select_prev_item(
            { behavior = cmp.SelectBehavior.Insert },
            { "i", "c" }
        ),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<CR>"] = cmp.config.disable,
    }),
    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 4 },
        { name = "dictionary", keyword_length = 4, },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore)
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore)
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
        ["*"] = { "~/.config/nvim/spell/en.utf-8.add", "/usr/share/dict/words" }
    },
    first_case_insensitive = true,
})

-- Setup lspconfig
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you"ve enabled
require("lspconfig")["clangd"].setup {
    capabilities = capabilities
}
