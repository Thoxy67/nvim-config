-- hop.lua - Quick navigation with labeled jumps
return {
  {
    "smoka7/hop.nvim",
    cmd = { "HopWord", "HopLine", "HopLineStart", "HopWordCurrentLine" },
    init = function()
      local map = vim.keymap.set
      -- Quick jump to any word
      map("n", "<leader><leader>w", "<cmd>HopWord<CR>", { desc = "Hint all words" })
      -- Jump to tree nodes (useful for code navigation)
      map("n", "<leader><leader>t", "<cmd>HopNodes<CR>", { desc = "Hint Tree" })
      -- Jump to line beginnings
      map("n", "<leader><leader>c", "<cmd>HopLineStart<CR>", { desc = "Hint Columns" })
      -- Jump within current line
      map("n", "<leader><leader>l", "<cmd>HopWordCurrentLine<CR>", { desc = "Hint Line" })
    end,
    opts = {
      keys = "etovxqpdygfblzhckisuran", -- Custom key sequence for hints
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "hop")
      require("hop").setup(opts)
    end,
  },
}
