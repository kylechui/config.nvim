local map = vim.keymap.set
-- Whenever our LSP server attaches to a buffer, load these keybinds
local setup_lsp_keybinds = function()
    map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
    map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
    map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
    map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
    map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
end

-- Automagically install the below LSP servers
local lsp_installer = require("nvim-lsp-installer")

-- Store the path to the LSP binaries given by nvim-lsp-installer
local server_root = vim.fn["stdpath"]("data") .. "/lsp_servers"
local server_binaries = {
    clangd = server_root .. "/clangd/clangd/bin/clangd",
    pyright = server_root .. "/python/node_modules/.bin/pyright-langserver",
    sumneko_lua = server_root .. "/sumneko_lua/extension/server/bin/lua-language-server",
    texlab = server_root .. "/latex/texlab",
}

-- Install the specified servers if they aren't already installed
for name, _ in pairs(server_binaries) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
        server:install()
    end
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
            -- Make the server aware of Neovim runtime files
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
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
