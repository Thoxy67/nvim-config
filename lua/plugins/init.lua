return {
  -- ===========================
  -- UI
  -- ===========================

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
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
      "MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
    },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    dependencies = { "Zeioth/mason-extra-cmds", opts = {} },
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
  { import = "plugins/languages/clang" },
  { import = "plugins/languages/cmake" },
  { import = "plugins/languages/docker" },
  { import = "plugins/languages/markdown" },

  -- {
  --   dir = "~/Dev/Lua/regex1337", -- Direct path to your plugin
  --   name = "regex-builder.nvim",
  --   cmd = {
  --     "RegexBuilderOpen",
  --     "RegexBuilderClose",
  --     "RegexBuilderToggle",
  --   },
  --   keys = {
  --     {
  --       "<leader>rx",
  --       "<cmd>RegexBuilderToggle<cr>",
  --       desc = "Toggle Regex Builder",
  --     },
  --   },
  --   opts = {
  --     -- Path to your regex-tester CLI (adjust as needed)
  --     cli_path = "/home/thoxy/Dev/Rust/regex1337/target/debug/regex1337", -- or full path like "/path/to/regex-tester"
  --
  --     -- Window configuration
  --     window_config = {
  --       width = 0.92,
  --       height = 0.85,
  --       pattern_height = 0.10,
  --       results_width = 0.32,
  --       gap = 3,
  --     },
  --
  --     auto_update = true,
  --     debounce_delay = 250,
  --
  --     highlights = {
  --       match = "RegexBuilderMatch",
  --       groups = {
  --         "RegexBuilderGroup1",
  --         "RegexBuilderGroup2",
  --         "RegexBuilderGroup3",
  --         "RegexBuilderGroup4",
  --         "RegexBuilderGroup5", -- Now this will work!
  --         -- You can add as many as you want
  --       },
  --       error = "RegexBuilderError",
  --     },
  --   },
  --
  --   config = function(_, opts)
  --     require("regex-builder").setup(opts)
  --   end,
  -- },

  -- { import = "plugins/languages/json" },
}
