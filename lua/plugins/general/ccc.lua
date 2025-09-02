-- ccc.lua - Color picker and highlighter
return {
  {
    "uga-rosa/ccc.nvim",
    event = "BufReadPost",
    cmd = { "CccPick", "CccConvert", "CccHighlighterToggle" },
    opts = {
      highlighter = {
        auto_enable = true, -- Automatically highlight colors in files
        lsp = true,         -- Use LSP for color information
      },
    },
    config = function(_, opts)
      require("ccc").setup(opts)
    end,
  },
}
