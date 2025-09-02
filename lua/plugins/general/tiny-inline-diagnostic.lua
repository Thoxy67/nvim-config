return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "BufRead",
    opts = {
      -- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
      preset = "modern",
      options = {
        -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
        show_source = {
          enabled = false,
          -- Show source only when multiple sources exist for the same diagnostic
          if_many = true,
        },
      },
    },
    priority = 1000,
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
      vim.diagnostic.config { virtual_text = false } -- Disable default virtual text
    end,
  },
}
