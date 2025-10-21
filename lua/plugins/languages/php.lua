-- ============================================================================
-- PHP LANGUAGE SUPPORT
-- lua/plugins/languages/php.lua
-- ============================================================================
-- Comprehensive PHP development environment featuring:
-- - Multiple LSP servers (Phpactor/Intelephense) for optimal coverage
-- - Advanced debugging with DAP integration
-- - Code formatting and linting with PHP-CS-Fixer and PHPCS
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lsp = vim.g.lazyvim_php_lsp or "phpactor"

-- ==================== SHARED CONFIGURATION ====================
-- Common settings for all PHP LSP servers
local root_markers = {
  "composer.json",
  ".phpactor.json",
  ".phpactor.yml",
}

local common_config = {
  on_attach = on_attach,
  filetypes = { "php" },
  root_markers = root_markers,
}

-- ==================== LSP SERVER CONFIGURATIONS ====================
-- Configure each PHP LSP server with specific capabilities
local servers = {
  -- Phpactor: PHP language server
  phpactor = {
    settings = {
      phpactor = {
        -- Phpactor-specific settings can be added here
      },
    },
  },

  -- Intelephense: PHP language server
  intelephense = {
    settings = {
      intelephense = {
        -- Intelephense-specific settings can be added here
      },
    },
  },
}

-- Apply common config to the selected LSP server
if servers[lsp] then
  local final_config = vim.tbl_deep_extend("force", common_config, servers[lsp])
  vim.lsp.config[lsp] = final_config
end

vim.lsp.enable { lsp }

return {
  -- Add packages (linting, formatting, debug adapter)
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "phpcs",
        "php-cs-fixer",
      },
    },
  },
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  -- Add linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.php = { "phpcs" }
      return opts
    end,
  },
  -- Add formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },
  -- Add formatting and linting
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.phpcsfixer,
        nls.builtins.diagnostics.phpcs,
      })
    end,
  },
  -- Add debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require "dap"
      dap.adapters.php = {
        type = "executable",
        command = "php-debug-adapter",
        args = {},
      }
    end,
  },
}
