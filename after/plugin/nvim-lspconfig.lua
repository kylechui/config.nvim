local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    print("Failed to load nvim-lspconfig")
    return
end

local map = vim.keymap.set
-- Whenever our LSP server attaches to a buffer, load these keybinds
local setup_lsp_keybinds = function()
    map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
    map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
    map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
    map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
    map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
end

lspconfig.clangd.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
})

local ht = require("haskell-tools")
ht.setup({
    hls = {
        on_attach = function()
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            setup_lsp_keybinds()
            map("n", "<space>c", vim.lsp.codelens.run, { buffer = true })
            map("n", "<space>hs", ht.hoogle.hoogle_signature, { buffer = true })
        end,
    },
})

lspconfig.ocamllsp.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
    single_file_support = true,
})

lspconfig.pyright.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
})

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup()

lspconfig.sumneko_lua.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})

lspconfig.texlab.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
})
