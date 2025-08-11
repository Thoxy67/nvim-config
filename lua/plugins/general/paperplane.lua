-- paperplane.lua - Share code snippets online
return {
  {
    "rktjmp/paperplanes.nvim",
    opts = {
      register = "+", -- Use system clipboard
      provider = "0x0.st", -- Paste service provider
      provider_options = {},
      notifier = vim.notify or print,
      save_history = true, -- Save paste history
    },
    config = function(_, opts)
      require("paperplanes").setup(opts)
    end,
  },
}
