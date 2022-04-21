---@diagnostic disable: undefined-global

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local packerUserConfig = augroup("packerUserConfig", {})
autocmd("BufWritePost", {
    pattern = {
        "packer.lua",
    },
    command = "source <afile> | PackerCompile",
    group = packerUserConfig,
})

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
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
    })
    use("akinsho/bufferline.nvim")
    -- File explorer
    use({
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
    })
    -- Color scheme
    use("rebelot/kanagawa.nvim")
    -- Treesitter for better syntax highlighting and other features
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/playground")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    -- Universal way to add comments
    use("numToStr/Comment.nvim")
    -- Surround stuff with delimiters
    use("tpope/vim-surround")
    -- LaTeX integration
    use("lervag/vimtex")
    -- Snippets
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
    -- Markdown viewing
    use("iamcco/markdown-preview.nvim")
    -- Formatter
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    -- Reverse join lines
    use("AckslD/nvim-trevJ.lua")
    -- Indent blanklines
    use("lukas-reineke/indent-blankline.nvim")
    -- LSP Stuff
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
    -- Autocomplete engine
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("uga-rosa/cmp-dictionary")
    use("saadparwaiz1/cmp_luasnip")
end)
