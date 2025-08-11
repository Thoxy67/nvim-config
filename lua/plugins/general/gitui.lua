return {
  {
    "aspeddro/gitui.nvim",
    opts = {},
    config = function(_, opts)
      require("gitui").setup(opts)
      vim.keymap.set("n", "<leader>g$", function()
        require("gitui").open()
      end, { desc = "GitUI Open" })
    end,
  },
}
