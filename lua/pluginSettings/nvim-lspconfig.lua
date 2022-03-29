require("lspconfig").clangd.setup({
    on_attach = function(client)
        vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
        vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
        vim.keymap.set("n", "<Leader>dl", "<Cmd>Telescope diagnostics<CR>", { buffer = 0 })
        vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = 0 })
        vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = 0 })

        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
})
--[[ require("lspconfig").tsserver.setup({
	on_attach = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
		vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
		vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
		vim.keymap.set("n", "<Leader>dl", "<Cmd>Telescope diagnostics<CR>", { buffer = 0 })
		vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = 0 })
		vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = 0 })
	end,
})
]]

local sumneko_root = os.getenv("HOME") .. "/lua-language-server"

require("lspconfig").sumneko_lua.setup({
    on_attach = function()
        vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
        vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
        vim.keymap.set("n", "<Leader>dl", "<Cmd>Telescope diagnostics<CR>", { buffer = 0 })
        vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = 0 })
        vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = 0 })
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
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
