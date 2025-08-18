-- neorg.lua - Note-taking and organization
return {
  {
    "nvim-neorg/neorg",
    enabled = false,
    ft = { "norg", "neorg" },
    cmd = "Neorg",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- opts = { ensure_installed = { "norg", "norg_meta", "norg_table" } },
      "benlubas/neorg-interim-ls", -- LSP support for neorg
    },
    opts = {
      load = {
        -- Core modules
        ["core.defaults"] = {},
        ["core.export"] = {},
        ["core.fs"] = {},
        ["core.storage"] = {},
        ["core.syntax"] = {},
        ["core.ui"] = {},
        ["core.neorgcmd"] = {},
        ["core.export.markdown"] = {},
        ["core.highlights"] = {},
        ["core.itero"] = {},
        ["core.journal"] = {},
        -- ["core.integrations.treesitter"] = {},

        -- Visual enhancements
        ["core.concealer"] = {
          config = {
            dim_code_blocks = {
              padding = { left = 4 },
            },
            icons = {
              todo = {
                done = { icon = "x" },
                pending = { icon = "-" },
                undone = { icon = " " },
                urgent = { icon = "!" },
              },
            },
          },
        },

        -- Directory management
        ["core.dirman"] = {
          config = {
            default_workspace = "work",
            workspaces = {
              work = "~/.neorg/work",
            },
          },
        },

        -- Completion support
        ["core.completion"] = {
          config = {
            engine = {
              module_name = "external.lsp-completion",
            },
          },
        },

        -- External LSP integration
        ["external.interim-ls"] = {
          config = {
            completion_provider = {
              enable = true,
              documentation = true,
              categories = false,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("neorg").setup(opts)
    end,
  },
}
