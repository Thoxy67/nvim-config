local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.svelte = {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "svelte",
  },
  root_markers = { "svelte.config.js", "svelte.config.mjs", "svelte.config.cjs" },
  settings = {
    svelte = {},
  },
}

-- Extend vtsls configuration to add Svelte plugin support
-- We need to defer this until after TypeScript config is loaded
vim.schedule(function()
  local vtsls_config = vim.lsp.config.vtsls or {}

  -- Add svelte filetype to vtsls if it's the selected TypeScript LSP
  if vim.g.typescript_lsp == "vtsls" then
    vtsls_config.filetypes = vtsls_config.filetypes or {}
    table.insert(vtsls_config.filetypes, "svelte")

    -- Add svelte root markers
    vtsls_config.root_markers = vtsls_config.root_markers or {}
    vim.list_extend(vtsls_config.root_markers, { "svelte.config.js", "svelte.config.mjs", "svelte.config.cjs" })

    -- Initialize nested settings structure
    vtsls_config.settings = vtsls_config.settings or {}
    vtsls_config.settings.vtsls = vtsls_config.settings.vtsls or {}
    vtsls_config.settings.vtsls.tsserver = vtsls_config.settings.vtsls.tsserver or {}
    vtsls_config.settings.vtsls.tsserver.globalPlugins = vtsls_config.settings.vtsls.tsserver.globalPlugins or {}

    -- Add svelte plugin to globalPlugins
    table.insert(vtsls_config.settings.vtsls.tsserver.globalPlugins, {
      name = "typescript-svelte-plugin",
      location = vim.fn.stdpath("data") .. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
      enableForWorkspaceTypeScriptVersions = true,
    })

    vim.lsp.config.vtsls = vtsls_config
  end
end)

vim.lsp.enable { "svelte", vim.g.typescript_lsp }

return {
  { import = "plugins.languages.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "svelte" } },
  },

  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "svelte-language-server",
      },
    },
  },
}
