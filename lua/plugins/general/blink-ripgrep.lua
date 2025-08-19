return {
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-git",
      },
      {
        "mikavilpas/blink-ripgrep.nvim",
        version = "*", -- use the latest stable version
      },
    },
    opts = {
      cmdline = {
        completion = {
          menu = {
            auto_show = false,
          },
          ghost_text = {
            enabled = true,
          },
        },
      },
      sources = {
        default = {
          "git",
          "lsp",
          "snippets",
          "buffer",
          "path",
          "cmdline",
          "omni",
          "ripgrep",
        },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- see the full configuration below for all available options
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {},
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {
              -- options for the blink-cmp-git
            },
          },
        },
      },
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}
