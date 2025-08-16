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
                "diff",
                "diagnostics",
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
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = {
            "lazy",
        },
    },
}
