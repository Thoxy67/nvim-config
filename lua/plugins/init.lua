return {
  -- ===========================
  -- UI
  -- ===========================

  { "nvzone/volt", lazy = true },

  {
    "nvzone/menu",
    lazy = true,
    init = function()
      vim.keymap.set("n", "<C-t>", function()
        require("menu").open "default"
      end, {})
      -- mouse users + nvimtree users!
      vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
        require("menu.utils").delete_old_menus()
        vim.cmd.exec '"normal! \\<RightMouse>"'
        -- clicked buf
        local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
        require("menu").open(options, { mouse = true })
      end, {})
    end,
  },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },

  -- ===========================
  -- LSP AND LANGUAGE SUPPORT
  -- ===========================

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- ===========================
  -- SYNTAX HIGHLIGHTING
  -- ===========================

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,

    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,

    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },

    opts = {
      highlight = { enable = true },
      indent = { enable = true },

      -- Languages to install
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "fish",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },

      -- Selection enhancement
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },

      -- Text object movements
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
      },
    },
  },

  -- ===========================
  -- PACKAGE MANAGEMENT
  -- ===========================

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },

    opts = {
      ensure_installed = {
        -- Add your tools here
        -- "stylua", "shfmt",
      },
    },

    config = function(...)
      require("configs.mason").setup(...)
    end,
  },

  -- ===========================
  -- CODE FORMATTING
  -- ===========================

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- ===========================
  -- COMPLETION
  -- ===========================

  { import = "nvchad.blink.lazyspec" },

  -- ===========================
  -- PLUGIN IMPORTS
  -- ===========================

  { import = "plugins/general" },
  { import = "plugins/dap" },

  -- Language-specific plugins (comment out what you don't need)
  { import = "plugins/languages/rust" },
  { import = "plugins/languages/gleam" },
  { import = "plugins/languages/v" },
  { import = "plugins/languages/zig" },
  { import = "plugins/languages/go" },
  { import = "plugins/languages/ocaml" },
  -- { import = "plugins/languages/json" },
}
