local map = vim.keymap.set

local setup_lsp_keybinds = function()
    map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
    map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
    map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = 0 })
    map("n", "<Leader>r", require("utils").rename_var, { buffer = 0 })
    map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = 0 })
end

require("lspconfig").clangd.setup({
    on_attach = function(client)
        setup_lsp_keybinds()
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        --[[ -- Preparing for when nvim-lspconfig updates to 0.7 APIs
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false ]]
    end,
})

local sumneko_root = os.getenv("HOME") .. "/lua-language-server"

require("lspconfig").sumneko_lua.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
    cmd = {
        sumneko_root .. "/bin/lua-language-server",
        "--preview",
        "-E",
        sumneko_root .. "/main.lua",
    },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = {
                globals = {
                    "vim",
                },
                neededFileStatus = {
                    ["codestyle-check"] = "Any",
                },
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    quote_style = "double",
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
