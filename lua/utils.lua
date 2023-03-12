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

return M
