return {
  "https://git.thoxy.xyz/thoxy/regxim",
  cmd = {
    "RegximOpen",
    "RegximClose",
    "RegximToggle",
    "RegximInstallCLI",
    "RegximRemoveCLI",
  },
  keys = {
    {
      "<leader>rx",
      "<cmd>RegximToggle<cr>",
      desc = "Toggle Regex Builder",
    },
  },
  opts = {
    -- Path to your regxim CLI (adjust as needed)
    cli_path = "regxim",

    -- Window configuration
    window_config = {
      width = 0.92,
      height = 0.85,
      pattern_height = 0.10,
      results_width = 0.32,
      gap = 3,
    },

    auto_update = true,
    debounce_delay = 250,

    highlights = {
      match = "RegximMatch",
      groups = {
        "RegximGroup1",
        "RegximGroup2",
        "RegximGroup3",
        "RegximGroup4",
        "RegximGroup5", -- Now this will work!
        -- You can add as many as you want
      },
      error = "RegximError",
    },
  },

  config = function(_, opts)
    require("regxim").setup(opts)
  end,
}
