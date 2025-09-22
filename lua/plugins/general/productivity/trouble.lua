-- trouble.lua - Diagnostics and quickfix enhancement
return {
  {
    "folke/trouble.nvim",
    opts = {},
    init = function()
      dofile(vim.g.base46_cache .. "trouble")
    end,
    cmd = "Trouble",
    -- stylua: ignore
    keys = {
      { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble Diagnostics" },
      { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble Buffer Diagnostics" },
      { "<leader>to", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble Symbols" },
      { "<leader>tL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble LSP Definitions / references / ..." },
      { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble Location List" },
      { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix List" },
    },
  },
}
