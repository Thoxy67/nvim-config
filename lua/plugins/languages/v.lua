local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- V ( https://vlang.io/ )
lspconfig.v_analyzer.setup({
  on_attach = on_attach,
  cmd = { vim.fn.expand('~') .. '/.config/v-analyzer/bin/v-analyzer' },
  filetypes = { 'v' },
  root_dir = util.root_pattern('v.mod', ".git"),
  settings = {
    -- v-analyzer specific settings
  },
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "v" } },
  },
}
