return {
  {
    "echasnovski/mini.map",
    version = false,
    keys = {
      {
        "<leader>um",
        function()
          require("mini.map").toggle()
        end,
        desc = "Toggle minimap",
      },
    },
    opts = function()
      local map = require "mini.map"
      return {
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic {
            error = "DiagnosticFloatingError",
            warn = "DiagnosticFloatingWarn",
            info = "DiagnosticFloatingInfo",
            hint = "DiagnosticFloatingHint",
          },
        },
      }
    end,
  },
}
