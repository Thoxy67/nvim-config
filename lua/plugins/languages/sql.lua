-- ============================================================================
-- SQL LANGUAGE SUPPORT
-- lua/plugins/languages/sql.lua
-- ============================================================================
-- Comprehensive SQL development environment featuring:
-- - vim-dadbod for database interaction and query execution
-- - Database UI (DBUI) for visual database management
-- - SQLFluff for linting and formatting (ANSI SQL dialect)
-- - Database-aware completion with dadbod-completion
-- - Support for SQL, MySQL, and PL/SQL dialects
-- ============================================================================

-- Supported SQL file types
local sql_ft = { "sql", "mysql", "plsql" }

return {
  -- ==================== DATABASE MANAGEMENT UI ====================
  -- Interactive database interface for managing connections and executing queries
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      { "tpope/vim-dadbod", cmd = "DB" }, -- Core database interaction plugin
      { "kristijanhusak/vim-dadbod-completion", ft = sql_ft }, -- SQL completion
    },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
    init = function()
      local data_path = vim.fn.stdpath "data"

      -- ==================== DBUI CONFIGURATION ====================
      vim.g.db_ui_auto_execute_table_helpers = 1 -- Auto-execute table helpers
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui" -- Save queries and connections
      vim.g.db_ui_show_database_icon = true -- Show database icons
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp" -- Temp query location
      vim.g.db_ui_use_nerd_fonts = true -- Use Nerd Font icons
      vim.g.db_ui_use_nvim_notify = true -- Use nvim-notify for messages

      -- Disable auto-execution on save (prevents crashes with large queries)
      -- Use <leader>S to manually execute queries
      vim.g.db_ui_execute_on_save = false

      -- Disable legacy SQL completion plugins
      vim.g.loaded_sql_completion = 1 -- Disable dbext-based completion
      vim.g.omni_sql_no_default_maps = 1 -- Disable default omni-completion maps
    end,
  },

  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for SQL
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "sql" } }, -- SQL parser
  },

  -- ==================== COMPLETION CONFIGURATION ====================
  -- Database-aware SQL completion with blink.cmp
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "dadbod" }, -- Use dadbod as completion source
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
    dependencies = {
      "kristijanhusak/vim-dadbod-completion", -- Database completion engine
    },
  },

  -- ==================== MASON TOOL INSTALLATION ====================
  -- Install SQLFluff for linting and formatting
  {
    "mason.nvim",
    opts = { ensure_installed = { "sqlfluff" } }, -- SQL linter and formatter
  },

  -- ==================== LINTING CONFIGURATION ====================
  -- SQLFluff linter for SQL code quality
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      for _, ft in ipairs(sql_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        table.insert(opts.linters_by_ft[ft], "sqlfluff") -- Add SQLFluff linter
      end
    end,
  },

  -- ==================== FORMATTING CONFIGURATION ====================
  -- SQLFluff formatter with ANSI SQL dialect
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters.sqlfluff = {
        args = { "format", "--dialect=ansi", "-" }, -- Use ANSI SQL dialect
      }
      for _, ft in ipairs(sql_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "sqlfluff") -- Add SQLFluff formatter
      end
    end,
  },
}
