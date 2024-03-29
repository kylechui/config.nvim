return {
    [1] = "epwalsh/obsidian.nvim",
    version = "^3.0.0",
    ft = { "markdown" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<Localleader>o",
            vim.cmd.ObsidianOpen,
        },
        {
            "<Localleader>b",
            vim.cmd.ObsidianBacklinks,
        },
        {
            mode = "x",
            [1] = "<Bslash>ll",
            [2] = function()
                local title = vim.fn.input("Note title: ")
                if title then
                    return ":ObsidianLinkNew " .. title .. "<CR>"
                end
            end,
            expr = true,
        },
    },
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
                local parent_dir = vim.fn.expand("%:h:t"):gsub("%s+", "")
                return {
                    id = note.id,
                    aliases = {},
                    tags = parent_dir == "obelisk" and {} or { parent_dir },
                }
            end,
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { expr = true, buffer = true },
                },
                ["<Leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },
        })
    end,
}
