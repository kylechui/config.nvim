return {
    "epwalsh/obsidian.nvim",
    ft = { "markdown" },
    keys = {
        {
            "<Localleader>n",
            function()
                local title = vim.fn.input("Note title: ")
                if title ~= "" then
                    return "<Cmd>ObsidianNew " .. title .. "<CR>"
                end
            end,
            expr = true,
        },
        {
            "<Localleader>o",
            "<Cmd>ObsidianOpen<CR>",
        },
        {
            mode = "x",
            "<Bslash>ll",
            function()
                local title = vim.fn.input("Note title: ")
                if title then
                    return ":ObsidianLink " .. title .. "<CR>"
                end
            end,
            expr = true,
        },
        {
            mode = "x",
            "<Bslash>ln",
            function()
                local title = vim.fn.input("Note title: ")
                return ":ObsidianLinkNew " .. title .. "<CR>"
            end,
            expr = true,
        },
    },
    version = "v1.*",
    config = function()
        require("obsidian").setup({
            dir = vim.env.OBSIDIAN_VAULT,
            completion = {
                nvim_cmp = true,
            },
            note_id_func = function(title)
                return title
            end,
            note_frontmatter_func = function(note)
                return {
                    id = note.id,
                    aliases = {},
                    tags = note.tags,
                }
            end,
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { expr = true, buffer = true },
                },
            },
        })
    end,
}
