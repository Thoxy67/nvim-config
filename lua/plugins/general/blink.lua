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
      "allaman/emoji.nvim",
      "saghen/blink.compat",
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
          "emoji",
        },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              prefix_min_len = 5,
              toggles = {
                -- The keymap to toggle the plugin on and off from blink
                -- completion results. Example: "<leader>tg" ("toggle grep")
                on_off = "<leader>rg",

                -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
                debug = nil,
              },
              gitgrep = {
                -- no options are currently available
              },
            },
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {
              -- options for the blink-cmp-git
            },
          },
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            -- overwrite kind of suggestion
            transform_items = function(_, items)
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              for i = 1, #items do
                items[i].kind = kind
              end
              return items
            end,
          },
        },
      },
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}
