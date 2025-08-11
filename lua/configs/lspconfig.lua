-- ============================================================================
-- LSP CONFIGURATION
-- lua/configs/lspconfig.lua
-- ============================================================================
-- Language Server Protocol configuration that extends NvChad's defaults
-- with additional language servers and custom settings.
-- ============================================================================

-- Load NvChad's default LSP configuration first
require("nvchad.configs.lspconfig").defaults()

-- ==================== BASIC LSP SERVERS ====================
-- Define language servers to enable automatically
-- More complex language configurations are in lua/plugins/languages/
local servers = {
  "html", -- HTML language server
  "cssls", -- CSS language server
  "taplo", -- TOML language server
}

-- Enable the defined language servers with default configuration
vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
