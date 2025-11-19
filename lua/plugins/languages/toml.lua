-- ============================================================================
-- TOML LANGUAGE SUPPORT
-- lua/plugins/languages/toml.lua
-- ============================================================================
-- TOML configuration file support featuring:
-- - Taplo LSP for validation, formatting, and diagnostics
-- - Support for Cargo.toml, pyproject.toml, and other TOML configs
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== TAPLO LSP SERVER ====================
-- Taplo provides comprehensive TOML language features:
-- - Syntax validation and error checking
-- - Schema validation (e.g., Cargo.toml structure validation)
-- - Auto-formatting
-- - Hover documentation
-- - Completion for known keys
vim.lsp.config.taplo = {
  on_attach = on_attach,
  filetypes = { "toml" },
  root_markers = { "*.toml", ".git" },
  settings = {
    taplo = {
      schema = {
        enabled = true, -- Enable schema validation
        catalog = "https://www.schemastore.org/api/json/catalog.json", -- Use schema catalog
      },
      formatter = {
        enabled = true, -- Enable auto-formatting
      },
    },
  },
}

-- Enable Taplo LSP server
vim.lsp.enable { "taplo" }

return {}
