return {
    {
        [1] = "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                [1] = "folke/lazydev.nvim",
                version = "^1.0.0",
                ft = "lua",
                opts = true,
            },
        },
        config = function()
            local map = vim.keymap.set
            -- Whenever our LSP server attaches to a buffer, load these keybinds
            local setup_lsp_keybinds = function()
                map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
                map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
                map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
                map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
                map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
            end

            -- Refreshes code lenses
            local create_codelens_autocmd = function(client)
                if client.supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                    local refreshCodelens = vim.api.nvim_create_augroup("refreshCodelens", {})
                    vim.api.nvim_create_autocmd({
                        "LspAttach",
                        "InsertLeave",
                        "TextChanged",
                    }, {
                        buffer = 0,
                        callback = vim.lsp.codelens.refresh,
                        group = refreshCodelens,
                    })
                end
            end

            local lspconfig = require("lspconfig")

            lspconfig.bashls.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            --[[ lspconfig.clangd.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
                single_file_support = true,
            }) ]]

            lspconfig.jsonls.setup({})

            lspconfig.lua_ls.setup({
                on_attach = function(c, b)
                    setup_lsp_keybinds()
                end,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        diagnostics = {
                            enable = true,
                        },
                        format = {
                            enable = false,
                        },
                        hint = {
                            enable = true,
                        },
                    },
                },
            })

            lspconfig.markdown_oxide.setup({
                root_dir = require("lspconfig.util").root_pattern(".obsidian"),
                single_file_support = false,
                on_attach = function(client)
                    create_codelens_autocmd(client)
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.ocamllsp.setup({
                on_attach = function(client)
                    create_codelens_autocmd(client)
                    setup_lsp_keybinds()
                end,
                settings = {
                    codelens = {
                        enable = true,
                    },
                },
                single_file_support = true,
            })

            lspconfig.pyright.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.nixd.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.texlab.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                    vim.keymap.set("n", "K", function()
                        local curpos = vim.api.nvim_win_get_cursor(0)
                        curpos[2] = curpos[2] + 1
                        local file = vim.fn.expand("%:p:r"):gsub(" ", "\\ ")
                        vim.fn.jobstart(
                            "zathura --synctex-forward "
                                .. tostring(curpos[1])
                                .. ":"
                                .. tostring(curpos[2])
                                .. ":"
                                .. file
                                .. ".tex "
                                .. file
                                .. ".pdf",
                            { detach = true }
                        )
                    end, { buffer = true })
                end,
            })
        end,
    },
    {
        [1] = "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        opts = {
            hint_enable = false,
        },
    },
    {
        [1] = "onsails/lspkind.nvim",
        event = "LspAttach",
    },
}
