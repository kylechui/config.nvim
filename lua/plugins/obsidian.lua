return {
    "epwalsh/obsidian.nvim",
    ft = { "markdown" },
    keys = {
        {
            "gf",
            function()
                if require("obsidian").util.cursor_on_markdown_link() then
                    return "<Cmd>ObsidianFollowLink<CR>"
                else
                    return "gf"
                end
            end,
            expr = true,
        },
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
        -- vim.keymap.set("x", "<Bslash>ll", function()
        --     local title = vim.fn.input("Note title: ")
        --     if title then
        --         return ":ObsidianLink " .. title .. "<CR>"
        --     end
        -- end, { buffer = true, silent = true, expr = true })
        -- vim.keymap.set("x", "<Bslash>ln", function()
        --     local title = vim.fn.input("Note title: ")
        --     return ":ObsidianLinkNew " .. title .. "<CR>"
        -- end, { buffer = true, silent = true, expr = true })
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
        })
    end,
}
