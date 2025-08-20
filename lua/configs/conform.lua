-- ============================================================================
-- CONFORM.NVIM CONFIGURATION
-- lua/configs/conform.lua
-- ============================================================================
-- Conform.nvim provides asynchronous formatting with support for multiple
-- formatters per filetype. This configuration sets up basic formatters
-- and enables format-on-save functionality.
-- ============================================================================

local options = {
  -- ==================== FORMATTERS BY FILETYPE ====================
  -- Define which formatters to use for each file type
  -- Language-specific formatters are configured in their respective language files
  formatters_by_ft = {
    -- Lua formatting with stylua
    lua = { "stylua" },

    -- Web technologies formatting with prettier
    css = { "prettier" },
    html = { "prettier" },
    graphql = { "prettier" },
    handlebars = { "prettier" },
    javascriptreact = { "prettier" },
    jsonc = { "biome" },
    less = { "prettier" },
    markdown = { "prettier" },
    scss = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "biome" },
    svelte = { "prettier" },
    bash = { "shfmt" },
    gleam = { "gleam" },
    go = { "gofmt" },
    ocaml = { "ocamlformat" },
    python = { "ruff_format" },
    toml = { "taplo" },
    yaml = { "yamlfmt" },
    zig = { "zigfmt" },
  },

  -- ==================== FORMAT ON SAVE CONFIGURATION ====================
  format_on_save = {
    timeout_ms = 500, -- Maximum time to wait for formatting
    lsp_fallback = true, -- Use LSP formatting if no formatter is configured
  },
}

return options
