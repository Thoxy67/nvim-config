local lang_manager = require("configs.language_manager")
local plugins = {

  -- ===========================
  -- LSP AND LANGUAGE SUPPORT
  -- ===========================

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- ===========================
  -- SYNTAX HIGHLIGHTING
  -- ===========================

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUninstall", "TSLog" },
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = require "configs.treesitter",
    config = function(_, opts)
      -- ensure_installed is no longer part of nvim-treesitter, so we must extract it manually.
      local ensure_installed = opts.ensure_installed
      --opts.ensure_installed = nil

      local nvim_treesitter = require "nvim-treesitter"
      nvim_treesitter.setup(opts)
      nvim_treesitter.install(ensure_installed):await(function(err)
        if err then
          vim.notify("Failed to install TreeSitter parsers: " .. err, vim.log.levels.WARN)
          return
        end
        -- start treesitter for all possible buffers
        -- not all buffers will be possible, so we will pcall this for best effort.
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          pcall(vim.treesitter.start, buf)
        end
      end)
    end,
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

  { import = "plugins/general/editing" },
  { import = "plugins/general/git" },
  { import = "plugins/general/lsp" },
  { import = "plugins/general/navigation" },
  { import = "plugins/general/productivity" },
  { import = "plugins/general/ui" },
  { import = "plugins/dap" },

  -- Language-specific plugins (dynamically loaded based on configuration)
  -- Use :LanguageManager to configure which languages to load

  { import = "plugins/AI" },

  -- { import = "plugins/dev" }, -- Homemade debug plugins
}

-- Add dynamic language imports
local language_imports = lang_manager.get_language_imports()
for _, import_spec in ipairs(language_imports) do
  table.insert(plugins, import_spec)
end

return plugins
