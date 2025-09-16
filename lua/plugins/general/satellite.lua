return {
  {
    "lewis6991/satellite.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
      excluded_filetypes = {
        "",
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "neo-tree",
        "help",
        "NvimTree",
        "Outline",
        "TelescopePrompt",
        "TelescopeResults",
        "Trouble",
        "aerial",
        "alpha",
        "checkhealth",
        "dashboard",
        "gitcommit",
        "help",
        "lazy",
        "lspinfo",
        "man",
        "mason",
        "neo-tree",
        "notify",
      },
    },
    config = function(_, opts)
      require("satellite").setup(opts)
    end,
  },
}
