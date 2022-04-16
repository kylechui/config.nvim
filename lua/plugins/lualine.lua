local word_count = function()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
        return string.format("%sW", vim.fn.wordcount().visual_words)
    else
        return string.format("%sW", vim.fn.wordcount().words)
    end
end

require("lualine").setup({
    options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
            {
                word_count,
                color = nil,
            },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    extensions = {
        "nvim-tree",
    }
})
