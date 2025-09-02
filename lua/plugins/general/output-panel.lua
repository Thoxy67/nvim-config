return {
  {
    "mhanberg/output-panel.nvim",
    opts = {
      max_buffer_size = 5000, -- default
    },
    config = function(_, opts)
      require("output_panel").setup(opts)
    end,
    cmd = { "OutputPanel" },
    keys = {
      { "<leader>op", vim.cmd.OutputPanel, mode = "n", desc = "Toggle the output panel" },
    },
  },
}
