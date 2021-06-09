local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

function M.AdjustFontSize(delta)
  local gf = vim.inspect(vim.opt.guifont:get())
  local font_size = gf:match(":h(%d+)")
  local updated = string.gsub(gf, ":h(%d+)", ":h" .. (font_size + delta))
  vim.opt.guifont=updated:sub(4, string.len(updated) - 3)
end

return M
