vim.keymap.set("n", "<Localleader>n", function()
    local title = vim.fn.input("Note title: ")
    return "<Cmd>ObsidianNew " .. title .. "<CR>"
end, { buffer = true, silent = true, expr = true })
