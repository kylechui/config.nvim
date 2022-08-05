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
local server_root = vim.fn.stdpath("data") .. "/mason/bin/"
local server_binaries = {
    clangd = server_root .. "clangd",
    pyright = server_root .. "pyright-langserver",
    sumneko_lua = server_root .. "lua-language-server",
    texlab = server_root .. "texlab",
}

require("lspconfig").clangd.setup({
    on_attach = function()
        setup_lsp_keybinds()
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
                enable = false,
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
