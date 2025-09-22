return {
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    opts = {
      keymaps = {
        -- Make each keymap completely unique
        normal = "<leader>sw",          -- "surround wrap"
        normal_cur = "<leader>sl",      -- "surround line"
        normal_line = "<leader>sW",     -- "surround Wrap with newlines"
        normal_cur_line = "<leader>sL", -- "surround Line with newlines"
        visual = "<leader>sw",          -- Visual surround wrap
        visual_line = "<leader>sW",     -- Visual line surround wrap
        delete = "<leader>sd",          -- "surround delete"
        change = "<leader>sc",          -- "surround change"
        change_line = "<leader>sC",     -- "surround Change with newlines"
      },
    },
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },
}
