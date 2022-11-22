local ok, mason = pcall(require, "mason")
if not ok then
    print("Failed to load mason.nvim")
    return
end

mason.setup()
