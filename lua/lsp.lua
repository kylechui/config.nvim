
local M = {}

-- Custom rename function to start with empty prompt
M.rename_var = function()
    local new_name = vim.fn.input({ prompt = "New name: " })
    if #new_name == 0 then
        return
    end
    vim.lsp.buf.rename(new_name)
end

-- Sets up common LSP keymaps
M.setup_lsp_keymaps = function(client)
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
    vim.keymap.set("n", "<Leader>dn", function()
        vim.diagnostic.jump({ count = 1 })
    end, { buffer = true })
    vim.keymap.set("n", "<Leader>dp", function()
        vim.diagnostic.jump({ count = -1 })
    end, { buffer = true })
    vim.keymap.set("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
    vim.keymap.set("n", "<Leader>r", M.rename_var, { buffer = true })
    vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
end

-- Refreshes code lenses
M.create_codelens_autocmd = function(client)
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

return M
