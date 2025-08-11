-- ccc.lua - Color picker and highlighter
return {
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccPick", "CccConvert", "CccHighlighterToggle" },
    config = function()
      require("ccc").setup {
        highlighter = {
          auto_enable = true, -- Automatically highlight colors in files
          lsp = true, -- Use LSP for color information
        },
      }
    end,
  },
}
