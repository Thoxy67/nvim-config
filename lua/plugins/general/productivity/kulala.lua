return {
  {
    {
      "mistweaverco/kulala.nvim",
      keys = {
        {
          "<leader>97",
          function()
            vim.cmd "enew"
            vim.bo.filetype = "http"
          end,
          mode = "n",
          "New HTTP buffer",
        },
      },
      ft = { "http", "rest" },
      opts = {
        global_keymaps = true,
        global_keymaps_prefix = "<leader>9",
        kulala_keymaps_prefix = "",
      },
    },
  },
}
