-- gitui.lua - Terminal UI for Git (external tool integration)
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>g$",
        function()
          require("snacks").terminal { "gitui" }
        end,
        desc = "GitUi (cwd)",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
    },
    requires = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>g!", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
