return {
  {
    "saecki/live-rename.nvim",
    opts = {},
    config = function(_, opts)
      local live_rename = require "live-rename"
      vim.keymap.set("n", "<leader>R", live_rename.map { text = "", insert = true }, { desc = "LSP rename" })
      vim.keymap.set("n", "<leader>R", function()
        live_rename.rename { text = "", insert = true }
      end, { desc = "LSP rename" })
      live_rename.setup(opts)
    end,
  },
}
