return {

  {
    "nvim-neorg/neorg",
    ft = { "norg", "neorg" },
    cmd = "Neorg",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "benlubas/neorg-interim-ls",
    },
    opts = {
      load = {
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
        ["core.dirman"] = {
          config = {
            default_workspace = "work",
            workspaces = {
              work = "~/.neorg/work",
            },
          },
        },
        ["core.completion"] = {
          config = {
            engine = {
              module_name = "external.lsp-completion",
            },
          },
        },
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
