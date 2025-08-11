-- gitui.lua - Terminal UI for Git (external tool integration)
return {
  {
    "aspeddro/gitui.nvim",
    opts = {},
    config = function(_, opts)
      require("gitui").setup(opts)
      -- Keymap to open GitUI
      vim.keymap.set("n", "<leader>g$", function()
        require("gitui").open()
      end, { desc = "GitUI Open" })
    end,
  },
}
