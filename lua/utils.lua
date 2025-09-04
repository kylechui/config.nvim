local M = {}

-- Change the font size by some amount delta
M.adjust_font_size = function(delta)
    local old_font = vim.opt.guifont["_value"]
    local font_size = string.match(old_font, ":h(%d+)$")
    local new_font = string.gsub(old_font, ":h(%d+)$", ":h" .. (font_size + delta))
    vim.opt.guifont = new_font
end

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
    vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, { buffer = true })
    vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, { buffer = true })
    vim.keymap.set("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
    vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = true })
    vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
end

return M
