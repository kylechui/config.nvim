---@diagnostic disable: undefined-global

vim.cmd([[
augroup packerUserConfig
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

return require("packer").startup(function()
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    -- Telescope nonsense
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    use("nvim-telescope/telescope-file-browser.nvim")
    -- Status line and bufferline
    use({
        "NTBBloodbath/galaxyline.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
    })
    use("akinsho/nvim-bufferline.lua")
    -- File explorer
    use({
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
    })
    -- Colour scheme
    use("eddyekofo94/gruvbox-flat.nvim")
    -- Treesitter for better syntax highlighting and other features
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/playground")
    -- Universal way to add comments
    use("numToStr/Comment.nvim")
    -- Surround stuff with delimiters
    use("tpope/vim-surround")
    -- LaTeX integration
    use("lervag/vimtex")
    -- Snippets
    -- use "sirver/ultisnips"
    use("L3MON4D3/LuaSnip")
    -- Get good
    use("ThePrimeagen/vim-be-good")
    -- Discord integration
    use("andweeb/presence.nvim")
    -- Highlight hex codes
    use("norcalli/nvim-colorizer.lua")
    -- Automatically insert pairs (for delimiters)
    use("windwp/nvim-autopairs")
    -- Git integration
    use("tpope/vim-fugitive")
    use({
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
    })
    -- Markdown viewing
    use("iamcco/markdown-preview.nvim")
    -- Startup analyser
    use("tweekmonster/startuptime.vim")
    -- Formatter
    -- use "mhartington/formatter.nvim"
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    -- LSP Stuff
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
    -- Autocomplete engine
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("uga-rosa/cmp-dictionary")
    use("saadparwaiz1/cmp_luasnip")
    -- use "quangnguyen30192/cmp-nvim-ultisnips"
end)
