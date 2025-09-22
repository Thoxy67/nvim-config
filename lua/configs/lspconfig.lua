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
  "html",    -- HTML language server
  "css_variables",
  "cssls",   -- CSS language server
  "somesass_ls",
  "taplo",   -- TOML language server
  "asm_lsp", -- assembly language server
  "ts_ls",
  "vtsls",   -- TypeScript/JavaScript
  "pyright",
  "basedpyright",
  "ruff",                            -- Python
  "clangd",                          -- C/C++
  "gopls",                           -- Go
  "zls",                             -- Zig
  "yamlls",                          -- YAML
  "jsonls",                          -- JSON
  "vue_ls",                          -- Vue
  "svelte",                          -- Svelte
  "dockerls",
  "docker_compose_language_service", -- Docker
  "neocmake",                        -- CMake
  "bashls",
  "fish_lsp",                        -- Shell
  "ols",                             -- Odin
  "marksman",                        -- Markdown
  "ocamllsp",                        -- OCaml
  "c3_lsp",                          -- C3
  "gleam",                           -- Gleam
  "v_analyzer",                      -- V
  "eslint",                          -- ESLint
  "bacon_ls",                        -- Rust diagnostics
}

-- ==================== SERVER ACTIVATION ====================
-- Enable basic language servers with default configuration
-- These servers work well with minimal configuration
vim.lsp.enable(servers)

-- ==================== PERFORMANCE OPTIMIZATION ====================
-- Optimize LSP performance by reducing unnecessary diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = "●", -- Simple prefix for virtual text
    source = "if_many", -- Show source only when multiple sources exist
  },
  signs = {
    priority = 20, -- Set diagnostic sign priority
  },
  float = {
    source = "always",      -- Always show source in floating diagnostics
    border = "rounded",     -- Rounded border for floating windows
  },
  severity_sort = true,     -- Sort diagnostics by severity
  update_in_insert = false, -- Don't update diagnostics in insert mode for performance
}

-- ==================== ADDITIONAL CONFIGURATION ====================
-- For advanced LSP customization, see:
-- :help vim.lsp.config for server-specific settings
-- :help lspconfig for general LSP configuration
-- Individual language files in lua/plugins/languages/ for complex setups
