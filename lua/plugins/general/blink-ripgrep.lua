return {
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "mikavilpas/blink-ripgrep.nvim",
        version = "*", -- use the latest stable version
      },
    },
    opts = {
      sources = {
        per_filetype = {
          markdown = {},
        },
        default = {
          "lsp",
          "snippets",
          "buffer",
          "path",
          "cmdline",
          "omni",
          "ripgrep", -- 👈🏻 add "ripgrep" here
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
        },
      },
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}
