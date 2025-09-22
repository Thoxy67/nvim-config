-- yazi.lua - Terminal file manager integration
return {
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    cmd = "Yazi",
    keys = {
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Yazi Open at the current file",
      },
      {
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi Open in the working directory",
      },
    },
    opts = {
      open_for_directories = false, -- Don't replace netrw completely
      keymaps = {
        show_help = "<f1>",
      },
    },
    init = function()
      -- Disable netrw to avoid conflicts
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
