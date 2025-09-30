local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.vue_ls = {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "vue",
  },
  root_markers = { "vue.config.js", "vue.config.ts" },
  settings = {
    vue_ls = {
      init_options = {
        vue = {
          hybridMode = true,
        },
      },
    },
  },
}

-- Extend vtsls configuration to add Vue plugin support
-- We need to defer this until after TypeScript config is loaded
vim.schedule(function()
  local vtsls_config = vim.lsp.config.vtsls or {}

  -- Add vue filetype to vtsls if it's the selected TypeScript LSP
  if vim.g.typescript_lsp == "vtsls" then
    vtsls_config.filetypes = vtsls_config.filetypes or {}
    table.insert(vtsls_config.filetypes, "vue")

    -- Add vue root markers
    vtsls_config.root_markers = vtsls_config.root_markers or {}
    vim.list_extend(vtsls_config.root_markers, { "vue.config.js", "vue.config.ts" })

    -- Initialize nested settings structure
    vtsls_config.settings = vtsls_config.settings or {}
    vtsls_config.settings.vtsls = vtsls_config.settings.vtsls or {}
    vtsls_config.settings.vtsls.tsserver = vtsls_config.settings.vtsls.tsserver or {}
    vtsls_config.settings.vtsls.tsserver.globalPlugins = vtsls_config.settings.vtsls.tsserver.globalPlugins or {}

    -- Add vue plugin to globalPlugins
    table.insert(vtsls_config.settings.vtsls.tsserver.globalPlugins, {
      name = "@vue/typescript-plugin",
      location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
      languages = { "vue" },
      configNamespace = "typescript",
      enableForWorkspaceTypeScriptVersions = true,
    })

    vim.lsp.config.vtsls = vtsls_config
  end
end)

vim.lsp.enable { "vue_ls", vim.g.typescript_lsp }

return {
  { import = "plugins.languages.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue", "css" } },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "vue-language-server",
      },
    },
  },
}
