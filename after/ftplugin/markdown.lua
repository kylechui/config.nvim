vim.opt_local.spell = true
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 80

vim.keymap.set("n", "<C-CR>", "<Cmd>MarkdownPreview<CR>", { buffer = true })
vim.keymap.set("n", "<Leader>u", function()
    require("cmp_dictionary").update()
end, { buffer = true })

vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<Cmd>ObsidianFollowLink<CR>"
    else
        return "gf"
    end
end, { buffer = true, silent = true, noremap = false, expr = true })
vim.keymap.set("n", "<Localleader>n", function()
    local title = vim.fn.input("Note title: ")
    if title then
        return "<Cmd>ObsidianNew " .. title .. "<CR>"
    end
end, { buffer = true, silent = true, expr = true })
vim.keymap.set("n", "<Localleader>o", function()
    return "<Cmd>ObsidianOpen<CR>"
end, { buffer = true, silent = true, expr = true })
vim.keymap.set("x", "<Localleader>ll", function()
    local title = vim.fn.input("Note title: ")
    if title then
        return ":ObsidianLink " .. title .. "<CR>"
    end
end, { buffer = true, silent = true, expr = true })
vim.keymap.set("x", "<Localleader>ln", function()
    local title = vim.fn.input("Note title: ")
    return ":ObsidianLinkNew " .. title .. "<CR>"
end, { buffer = true, silent = true, expr = true })

require("nvim-surround").buffer_setup({
    surrounds = {
        ["l"] = {
            add = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return {
                    { "[" },
                    { "](" .. clipboard .. ")" },
                }
            end,
            find = "%b[]%b()",
            delete = "^(%[)().-(%]%b())()$",
            change = {
                target = "^()()%b[]%((.-)()%)$",
                replacement = function()
                    local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                    return {
                        { "" },
                        { clipboard },
                    }
                end,
            },
        },
    },
})
