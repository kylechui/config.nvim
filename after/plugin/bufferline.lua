local ok, bufferline = pcall(require, "bufferline")
if not ok then
    print("Failed to load bufferline.nvim")
    return
end

bufferline.setup()
