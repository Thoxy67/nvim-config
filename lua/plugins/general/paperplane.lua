return {
  {
    "rktjmp/paperplanes.nvim",
    opts = {
      register = "+",
      provider = "0x0.st",
      provider_options = {},
      notifier = vim.notify or print,
      save_history = true,
    },
    config = function(_, opts)
      require("paperplanes").setup(opts)
    end,
  },
}
