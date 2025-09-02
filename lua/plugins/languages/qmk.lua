return {
  {
    "codethread/qmk.nvim",
    ft = { "c", "keymap", "dts" },
    opts = {
      name = "dumb",
      layout = { "x x" },
    },
    config = function(_, opts)
      local group = vim.api.nvim_create_augroup("MyQMK", {})

      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Format gmmk keymap",
        group = group,
        pattern = "gmmk2/*/keymap.c",
        callback = function()
          require("qmk").setup {
            name = "LAYOUT",
            auto_format_pattern = "*/keymap.c",
            layout = {
              "x x x x x x x x x x x x x _ x _ _ x x x x _",
              "x x x x x x x x x x x x x _ x _ _ x x x x _",
              "x x x x x x x x x x x x x _ x _ _ x x x x _",
              "x x x x x x x x x x x x x _ _ _ _ x x x _ _",
              "x x x x x x x x x x x x x _ _ x _ x x x x _",
              "x x x xxxxxx^xxxxxx x x x _ x x x _ x x _ _",
            },
            variant = "qmk",
          }
        end,
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Format sofle keymap",
        group = group,
        pattern = "*sofle.keymap",
        callback = function()
          require("qmk").setup {
            name = "LAYOUT_preonic_grid",
            layout = {
              "_ x x x x x x _ x x x x x x x",
              "_ x x x x x x _ x x x x x x x",
              "_ x x x x x x _ x x x x x x x",
              "_ x x x x x x _ x x x x x x x",
              "_ x x x x x x _ x x x x x x _",
            },
            variant = "zmk",
          }
        end,
      })

      require("qmk").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "devicetree" }, -- ZMK zephyr devicetree
    },
  },
}
