-- yanky.lua - Enhanced yank/paste with history
return {
  {
    "gbprod/yanky.nvim",
    recommended = true,
    desc = "Better Yank/Paste with history tracking",
    event = "BufEnter",
    opts = {
      highlight = { timer = 150 }, -- Highlight yanked text briefly
    },
    keys = {
      -- Basic yank/paste operations (keep these as-is)
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Copy Text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },

      -- Use leader-based navigation to avoid bracket conflicts
      { "<leader>yn", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
      { "<leader>yp", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },

      -- Indented paste operations (these are fine as-is)
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },

      -- Shift and filter operations (avoid < and > conflicts)
      { "<leader>y>", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
      { "<leader>y<", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
      { "<leader>yP>", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
      { "<leader>yP<", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
    },
  },
}
