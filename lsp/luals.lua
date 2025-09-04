return {
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
    on_attach = require("utils").setup_lsp_keymaps,
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
