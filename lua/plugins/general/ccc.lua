-- ccc.lua - Color picker and highlighter
return {
  {
    "uga-rosa/ccc.nvim",
    event = "BufReadPost",
    keys = {
      { "<leader>cF", "<cmd>CccConvert<CR>",           mode = "n", desc = "Convert color format" },
      { "<leader>cH", "<cmd>CccHighlighterToggle<CR>", mode = "n", desc = "Toggle color highlighter" },
      { "<leader>cP", "<cmd>CccPick<CR>",              mode = "n", desc = "Open color picker (CCC)" },
    },
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
