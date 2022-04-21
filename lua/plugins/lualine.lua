-- Gets the number of words in the file, or the number of words in the current
-- visual selection
local word_count = function()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
        return string.format("%sW", vim.fn.wordcount().visual_words)
    else
        return string.format("%sW", vim.fn.wordcount().words)
    end
end

require("lualine").setup({
    options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diff",
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
            },
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                },
            }
        },
        lualine_c = {
            {
                "filetype",
                icon_only = true,
                padding = {
                    left = 1,
                    right = 0,
                },
                separator = {
                    right = "",
                },
            },
            "filename",
        },
        lualine_x = { word_count },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    extensions = {
        "nvim-tree",
    }
})
