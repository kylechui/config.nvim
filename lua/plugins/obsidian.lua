return {
    "epwalsh/obsidian.nvim",
    ft = { "markdown", "NvimTree" },
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
