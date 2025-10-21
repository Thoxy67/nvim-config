-- ============================================================================
-- KOTLIN LANGUAGE SUPPORT
-- lua/plugins/languages/kotlin.lua
-- ============================================================================
-- Comprehensive Kotlin development environment featuring:
-- - Kotlin Language Server for code intelligence
-- - ktlint for linting and formatting
-- - Debug Adapter Protocol (DAP) support for debugging
-- - Support for Gradle and Maven build systems
-- - Treesitter syntax highlighting
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== KOTLIN LSP CONFIGURATION ====================
-- Kotlin Language Server provides IntelliSense and code navigation
vim.lsp.config.kotlin_language_server = {
  on_attach = on_attach,
  filetypes = { "kotlin" },
  root_markers = {
    "settings.gradle",       -- Gradle settings (Groovy)
    "settings.gradle.kts",   -- Gradle settings (Kotlin DSL)
    "build.xml",             -- Ant build file
    "pom.xml",               -- Maven project file
    "build.gradle",          -- Gradle build (Groovy)
    "build.gradle.kts",      -- Gradle build (Kotlin DSL)
  },
}

vim.lsp.enable { "kotlin_language_server" }

return {
  -- ==================== MASON TOOL INSTALLATION ====================
  -- Install ktlint for linting and formatting
  {
    "mason.nvim",
    opts = { ensure_installed = { "ktlint" } }, -- Kotlin linter and formatter
  },

  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for Kotlin
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } }, -- Kotlin parser
  },

  -- ==================== LINTING CONFIGURATION ====================
  -- ktlint linter for code quality
  {
    "mfussenegger/nvim-lint",
    dependencies = "mason.nvim",
    opts = {
      linters_by_ft = { kotlin = { "ktlint" } }, -- Use ktlint for linting
    },
  },

  -- ==================== FORMATTING CONFIGURATION ====================
  -- ktlint formatter for code style
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { kotlin = { "ktlint" } }, -- Use ktlint for formatting
    },
  },

  -- ==================== NULL-LS INTEGRATION ====================
  -- Additional linting and formatting via null-ls
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.ktlint,   -- ktlint formatting
        nls.builtins.diagnostics.ktlint,  -- ktlint diagnostics
      })
    end,
  },

  -- ==================== DEBUG ADAPTER PROTOCOL ====================
  -- DAP configuration for debugging Kotlin applications
  {
    "mfussenegger/nvim-dap",
    dependencies = "mason.nvim",
    opts = function()
      local dap = require "dap"

      -- Configure Kotlin debug adapter if not already set
      if not dap.adapters.kotlin then
        dap.adapters.kotlin = {
          type = "executable",
          command = "kotlin-debug-adapter",
          options = { auto_continue_if_many_stopped = false },
        }
      end

      -- Debug configurations for Kotlin
      dap.configurations.kotlin = {
        -- Launch configuration for running the current file
        {
          type = "kotlin",
          request = "launch",
          name = "This file",
          -- Dynamically compute the main class name from file path
          -- NOTE: Build your project before debugging
          -- File path mapping: src/main/kotlin/websearch/Main.kt -> websearch.MainKt
          mainClass = function()
            local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
            local fname = vim.api.nvim_buf_get_name(0)
            -- Convert file path to fully qualified class name
            return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
          end,
          projectRoot = "${workspaceFolder}",
          jsonLogFile = "",
          enableJsonLogging = false,
        },
        -- Attach configuration for debugging unit tests
        -- Usage: Run './gradlew --info cleanTest test --debug-jvm' first,
        -- then attach the debugger using this configuration
        {
          type = "kotlin",
          request = "attach",
          name = "Attach to debugging session",
          port = 5005,            -- Default debug port
          args = {},
          projectRoot = vim.fn.getcwd,
          hostName = "localhost",
          timeout = 2000,         -- Connection timeout in milliseconds
        },
      }
    end,
  },
}
