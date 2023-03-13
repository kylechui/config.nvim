local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local ok, packer = pcall(require, "packer")
if not ok then
    return
end

local packerUserConfig = augroup("packerUserConfig", {})
autocmd("BufWritePost", {
    pattern = "packer.lua",
    callback = function()
        vim.cmd.source("<afile>")
    end,
    group = packerUserConfig,
})

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd.packadd("packer.nvim")
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

return packer.startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Telescope nonsense
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = "nvim-lua/plenary.nvim",
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    use("nvim-telescope/telescope-file-browser.nvim")
    -- Status line and bufferline
    use({
        "nvim-lualine/lualine.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    })
    use("akinsho/bufferline.nvim")
    -- File explorer
    use({
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
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
    -- LaTeX integration
    use("lervag/vimtex")
    -- Haskell integration
    use({
        "MrcJkb/haskell-tools.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        tag = "1.4.0",
    })
    -- Snippets
    use("L3MON4D3/LuaSnip")
    -- Discord integration
    use("andweeb/presence.nvim")
    -- Highlight hex codes
    use("norcalli/nvim-colorizer.lua")
    -- Automatically insert pairs (for delimiters)
    use("windwp/nvim-autopairs")
    -- Git integration
    use("tpope/vim-fugitive")
    -- Configure Markdown viewing
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
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
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("onsails/lspkind.nvim")
    use("ray-x/lsp_signature.nvim")
    -- Autocomplete engine
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("uga-rosa/cmp-dictionary")
    use("saadparwaiz1/cmp_luasnip")

    use("folke/neodev.nvim")

    ---[=[
    use({
        --[[ "kylechui/nvim-surround",
        tag = "*", ]]
        "/home/kylec/Documents/github/nvim-surround/main",
        -- "kylechui/nvim-surround",
    })
    --]=]
    use({
        "glacambre/firenvim",
        run = function()
            vim.fn["firenvim#install"](0)
        end,
        config = function()
            vim.g.firenvim_config = {
                localSettings = {
                    [".*"] = {
                        takeover = "never",
                    },
                },
            }
        end,
    })
    -- Automatic parenthesis balancing for lispy languages
    use("eraserhd/parinfer-rust")
    if packer_bootstrap then
        packer.sync()
    end
end)
