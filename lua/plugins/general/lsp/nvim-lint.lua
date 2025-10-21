-- ============================================================================
-- NVIM-LINT CONFIGURATION
-- lua/plugins/general/lsp/nvim-lint.lua
-- ============================================================================
-- Asynchronous linter plugin for Neovim
-- Provides linting functionality for various file types
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function(_, opts)
    local lint = require("lint")

    -- Merge user-provided linters_by_ft with defaults
    lint.linters_by_ft = opts.linters_by_ft or {}

    -- Create autocommand for linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if the buffer is modifiable and not a special buffer
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })
  end,
}
