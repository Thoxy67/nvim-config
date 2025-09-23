-- ============================================================================
-- Typescipt / Javascipt LANGUAGE SUPPORT
-- lua/plugins/languages/typescript.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.eslint = {
  on_attach = on_attach,
  enabled = false,
  settings = {
    workingDirectories = { mode = "auto" },
    format = true,
    eslint = {},
  },
}

vim.lsp.enable { "eslint" }

return {
  { import = "plugins.languages.typescript" },
}
