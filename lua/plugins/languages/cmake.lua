-- ============================================================================
-- Cmake LANGUAGE SUPPORT
-- lua/plugins/languages/cmake.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

lspconfig.zls.setup {
  on_attach = on_attach,
  filetypes = { "cmake" },
  root_dir = util.root_pattern("CMakePresets.json", "CTestConfig.cmake", "cmake"),
  settings = {
    cmake = {},
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.cmake_lint,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "cmakelang", "cmakelint" } },
  },
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load { plugins = { "cmake-tools.nvim" } }
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = {},
  },
}
