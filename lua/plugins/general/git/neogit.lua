-- neogit.lua - Modern Git interface inspired by Magit
return {
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit", "NeogitCommit", "NeogitLogCurrent", "NeogitResetState" },
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        desc = "Open Neogit",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required dependency
      "sindrets/diffview.nvim", -- Enhanced diff viewing
      "nvim-telescope/telescope.nvim", -- File picker integration
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "neogit") -- Load theme
      require("neogit").setup(opts)
    end,
  },
}
