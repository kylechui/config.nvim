local map = vim.keymap.set

local server_root = vim.fn["stdpath"]("data") .. "/lsp_servers"
local sumneko_root = server_root .. "/sumneko_lua/extension/server"

local server_binaries = {
    clangd = server_root .. "/clangd/clangd/bin/clangd",
    pyright = server_root .. "/python/node_modules/.bin/pyright-langserver",
    sumneko_lua = sumneko_root .. "/bin/lua-language-server",
    texlab = server_root .. "/latex/texlab",
}

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
    cmd = {
        server_binaries["clangd"],
    },
})

require("lspconfig").pyright.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
    cmd = {
        server_binaries["pyright"],
        "--stdio",
    },
})

require("lspconfig").sumneko_lua.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
    cmd = {
        server_binaries["sumneko_lua"],
        "--preview",
        "-E",
        sumneko_root .. "/main.lua",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
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

require("lspconfig").texlab.setup({
    on_attach = function()
        setup_lsp_keybinds()
    end,
    cmd = {
        server_binaries["texlab"],
    },
})
