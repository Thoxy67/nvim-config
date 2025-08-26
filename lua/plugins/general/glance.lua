return {
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    opts = {
      height = 25,
      border = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("glance").setup(opts)
      vim.keymap.set("n", "<space>Gd", "<cmd>Glance definitions<cr>")
      vim.keymap.set("n", "<space>Gr", "<cmd>Glance references<cr>")
      vim.keymap.set("n", "<space>Gi", "<cmd>Glance implementations<cr>")
    end,
  },
}
