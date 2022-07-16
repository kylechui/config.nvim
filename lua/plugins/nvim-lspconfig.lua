local map = vim.keymap.set
-- Whenever our LSP server attaches to a buffer, load these keybinds
local setup_lsp_keybinds = function()
    map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
    map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
    map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
    map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
    map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
end

-- Store the path to the LSP binaries given by nvim-lsp-installer
local server_root = vim.fn["stdpath"]("data") .. "/lsp_servers"
local server_binaries = {
    clangd = server_root .. "/clangd/clangd/bin/clangd",
    pyright = server_root .. "/pyright/node_modules/.bin/pyright-langserver",
    sumneko_lua = server_root .. "/sumneko_lua/extension/server/bin/lua-language-server",
    texlab = server_root .. "/texlab/texlab",
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup({
    ensure_installed = {
        "clangd",
        "pyright",
        "sumneko_lua",
        "texlab",
    },
    automatic_installation = true,
})

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
    on_attach = function(client)
        setup_lsp_keybinds()
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
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
