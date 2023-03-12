local ok, telescope = pcall(require, "telescope")
if not ok then
    print("Failed to load telescope.nvim")
    return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
                ["q"] = require("telescope.actions").close,
            },
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.6,
                results_width = 0.25,
            },
            vertical = {
                mirror = false,
            },
            width = 0.85,
            height = 0.85,
            preview_cutoff = 60,
        },
        border = {},
    },
})

telescope.load_extension("fzf")
