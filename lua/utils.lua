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
    local position_params = vim.lsp.util.make_position_params()
    local new_name = vim.fn.input("New name: ")

    if #new_name == 0 then
        return
    end

    position_params.newName = new_name

    vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, method, result, ...)
        vim.lsp.handlers["textDocument/rename"](err, method, result, ...)
    end)
end

return M
