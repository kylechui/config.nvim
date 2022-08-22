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

M.compile_and_run = function(args)
    -- Get the buffer number, if it exists
    local bufnr = vim.fn.bufnr(args.name)
    if bufnr == -1 then
        bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(bufnr, args.name)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { ("="):rep(34) .. " STARTING UP " .. ("="):rep(33) })
    -- Compile and run the program
    vim.fn.jobstart(table.concat(args.cmd, " "), {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
        on_exit = function()
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { ("="):rep(35) .. " COMPLETE " .. ("="):rep(35) })
        end,
    })
    -- Open a new split if the buffer is not open
    if #vim.fn.win_findbuf(bufnr) == 0 then
        if vim.api.nvim_win_get_width(0) >= 178 then
            vim.cmd("noswapfile botright 86vsplit")
        else
            vim.cmd("noswapfile botright 15split")
        end
        -- Set the current buffer to the output window
        vim.api.nvim_set_current_buf(bufnr)
    end
end

return M
