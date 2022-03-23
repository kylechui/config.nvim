-- Setup nvim-cmp
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item
        -- Set `select` to `false` to only confirm explicitly selected items
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore)
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore)
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

-- Setup lspconfig
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you"ve enabled
require("lspconfig")["clangd"].setup {
    capabilities = capabilities
}

require("lspconfig")["pyright"].setup {
    capabilities = capabilities
}

local nvim_lsp = require("lspconfig")
local pid = vim.fn.getpid()
local omnisharp_bin = vim.fn.getenv("HOME") .. "/repos/omnisharp-linux-x64/run"
require("lspconfig").omnisharp.setup({
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern(".sln") or nvim_lsp.util.root_pattern(".csproj")
})
