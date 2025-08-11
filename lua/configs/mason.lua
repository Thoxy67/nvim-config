-- ============================================================================
-- MASON CONFIGURATION
-- lua/configs/mason.lua
-- ============================================================================
-- Mason manages external tools like LSP servers, formatters, linters, and
-- debug adapters. This configuration provides automatic installation and
-- integration with other plugins.
-- ============================================================================

local M = {}

-- ==================== MASON SETUP FUNCTION ====================
---@param opts MasonSettings | {ensure_installed: string[]}
M.setup = function(_, opts)
  -- Initialize Mason with provided options
  require("mason").setup(opts)
  local mr = require "mason-registry"

  -- ==================== POST-INSTALLATION HOOKS ====================
  -- Trigger events after successful package installation
  mr:on("package:install:success", function()
    vim.defer_fn(function()
      -- Trigger FileType event to load newly installed LSP servers
      -- This ensures LSP servers are available immediately after installation
      require("lazy.core.handler.event").trigger {
        event = "FileType",
        buf = vim.api.nvim_get_current_buf(),
      }
    end, 100) -- Small delay to ensure installation is complete
  end)

  -- ==================== AUTOMATIC TOOL INSTALLATION ====================
  -- Install tools that are specified in ensure_installed
  mr.refresh(function()
    for _, tool in ipairs(opts.ensure_installed) do
      local p = mr.get_package(tool)
      -- Only install if not already installed
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M
