local M = {}

-- Change the font size by some amount delta
function M.adjust_font_size(delta)
    local old_font = vim.opt.guifont["_value"]
    local font_size = string.match(old_font, ":h(%d+)$")
    local new_font = string.gsub(old_font, ":h(%d+)$", ":h" .. (font_size + delta))
    vim.opt.guifont = new_font
end

-- Custom rename function to start with empty prompt
function M.rename_var()
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
