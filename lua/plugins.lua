local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Telescope nonsense
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.5-compat',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- Status line and bufferline
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'akinsho/nvim-bufferline.lua'
    -- File explorer
    use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
    -- Colour scheme
    use 'eddyekofo94/gruvbox-flat.nvim'
    -- Treesitter for better syntax highlighting
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }
    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = '0.5-compat',
    }
    use 'nvim-treesitter/playground'
    -- Universal way to add comments
    use 'b3nj5m1n/kommentary'
    -- Surround stuff with delimiters
    use 'tpope/vim-surround'
    -- LaTeX integration
    use 'lervag/vimtex'
    -- Snippets
    use 'sirver/ultisnips'
    -- Get good
    use 'ThePrimeagen/vim-be-good'
    -- Discord integration
    use 'andweeb/presence.nvim' 
    -- Highlight hex codes
    use 'norcalli/nvim-colorizer.lua'
    -- Automatically insert pairs (for delimiters)
    use 'windwp/nvim-autopairs'
    -- Git integration
    use 'tpope/vim-fugitive'
    -- Markdown viewing
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
    -- Startup analyser
    use 'tweekmonster/startuptime.vim'
    -- LSP Stuff
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
end)
