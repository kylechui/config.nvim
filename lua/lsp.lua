-- Whenever our LSP server attaches to a buffer, load these keybinds
local setup_lsp_keybinds = function(client)
    if client.supports_method("textDocument/hover") then
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
    end
    if client.supports_method("textDocument/inlayHints") then
        vim.keymap.set("n", "<Leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { buffer = true })
    end
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
    vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, { buffer = true })
    vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, { buffer = true })
    vim.keymap.set("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
    vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = true })
    vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
end

vim.lsp.config.luals = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
            "lua/?.lua",
            "lua/?/init.lua",
        },
    },
    on_attach = setup_lsp_keybinds,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            diagnostics = {
                enable = true,
                -- Some functions used for writing unit tests
                globals = {
                    "describe",
                    "before_each",
                    "it",
                },
            },
            -- Disable luals formatting since it is handled by stylua
            format = {
                enable = false,
            },
            hint = {
                enable = true,
            },
        },
    },
}

vim.lsp.enable({ "luals" })
