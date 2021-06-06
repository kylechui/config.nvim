require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      ["punctuation.delimiter"] = "TSInclude",
      ["punctuation.special"] = "TSInclude",
      ["text.math"] = "TSFunction",
      ["text.title"] = "TSParameter",
    }
  },
}
