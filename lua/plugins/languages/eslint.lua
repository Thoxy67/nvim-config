-- ============================================================================
-- ESLINT LANGUAGE SERVER
-- lua/plugins/languages/eslint.lua
-- ============================================================================
-- ESLint integration for JavaScript/TypeScript linting and formatting
-- Works in conjunction with the TypeScript language configuration
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== ESLINT LSP CONFIGURATION ====================
-- ESLint language server for JavaScript/TypeScript linting
vim.lsp.config.eslint = {
  on_attach = on_attach,
  enabled = false, -- Disabled by default; enable if needed for your project
  settings = {
    -- Automatically detect working directories for monorepo support
    workingDirectories = { mode = "auto" },
    format = true, -- Enable ESLint formatting capabilities
    eslint = {}, -- Additional ESLint-specific settings
  },
}

vim.lsp.enable { "eslint" }

return {
  -- Import TypeScript language configuration
  -- ESLint works alongside TypeScript/JavaScript LSP servers
  { import = "plugins.languages.typescript" },
}
