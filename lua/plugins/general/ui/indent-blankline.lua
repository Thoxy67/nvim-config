-- indent-blankline.lua - Visual indentation guides
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    dependencies = {
      "TheGLander/indent-rainbowline.nvim", -- Rainbow colored indent lines
    },
    opts = function(_, opts)
      -- First apply the base configuration
      local base_opts = {
        indent = { char = "│", highlight = "IblChar" },
        scope = { char = "│", highlight = "IblScopeChar" },
      }

      -- Merge with any existing opts
      opts = vim.tbl_deep_extend("force", base_opts, opts or {})

      -- Apply rainbow line configuration
      return require("indent-rainbowline").make_opts(opts)
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
      dofile(vim.g.base46_cache .. "blankline")
    end,
    init = function()
      local map = vim.keymap.set
      -- Jump to current context (useful for large functions/blocks)
      map("n", "<leader>cc", function()
        local config = { scope = {} }
        config.scope.exclude = { language = {}, node_type = {} }
        config.scope.include = { node_type = {} }
        local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)
        if node then
          local start_row, _, end_row, _ = node:range()
          if start_row ~= end_row then
            vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
            vim.api.nvim_feedkeys("_", "n", true)
          end
        end
      end, { desc = "Blankline Jump to current context" })
    end,
  },
}
