local ok, presence = pcall(require, "presence")
if not ok then
    print("Failed to load presence.nvim")
    return
end

presence:setup({
    main_image = "file",
})
