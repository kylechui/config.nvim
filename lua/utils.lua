local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.adjust_font_size(delta)
    local gf = vim.inspect(vim.opt.guifont:get())
    local font_size = gf:match(":h(%d+)")
    local updated = string.gsub(gf, ":h(%d+)", ":h" .. (font_size + delta))
    vim.opt.guifont = updated:sub(4, string.len(updated) - 3)
end

function M.get_help(file)
    local help_string = "h " .. file
    if M.is_buffer_empty() then
        help_string = help_string .. " | only"
    end
    vim.cmd(help_string)
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
