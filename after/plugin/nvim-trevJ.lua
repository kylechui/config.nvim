local ok, trevj = pcall(require, "trevj")
if not ok then
    print("Failed to load nvim-trevJ.lua")
    return
end

trevj.setup()
