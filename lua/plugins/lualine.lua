return {
    [1] = "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            section_separators = "",
            component_separators = "│",
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
                },
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
            lualine_x = {
                function()
                    local count
                    if (vim.fn.mode()):lower() == "v" then
                        count = vim.fn.wordcount().visual_words
                    else
                        count = vim.fn.wordcount().words
                    end
                    return ("%sW"):format(count)
                end,
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = {
            "lazy",
        },
    },
}
