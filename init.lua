-- Get path to my lua config files
local config = vim.api.nvim_exec([[echo stdpath('config')]], true)..'/lua/'

-- Plugin Shenanigans
-- I use dofile instead of require so I can reload my settings without closing
-- and reopening NeoVim
dofile(config..'plugins.lua')
dofile(config..'pluginSettings/galaxyline.lua')
dofile(config..'pluginSettings/nvim-autopairs.lua')
dofile(config..'pluginSettings/nvim-colorizer.lua')
dofile(config..'pluginSettings/nvim-tree.lua')
dofile(config..'pluginSettings/nvim-treesitter.lua')
dofile(config..'pluginSettings/presence.lua')
dofile(config..'pluginSettings/telescope.lua')
dofile(config..'pluginSettings/ultisnips.lua')
dofile(config..'pluginSettings/vimtex.lua')

dofile(config..'settings.lua')
dofile(config..'keybinds.lua')
