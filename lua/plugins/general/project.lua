return {
  {
    "DrKJeff16/project.nvim",
    opts = {
      manual_mode = true,
    },
    config = function(_, opts)
      require("project").setup(opts)
      require("telescope").setup {
        extensions = {
          projects = {
            layout_strategy = "horizontal",
            layout_config = {
              anchor = "N",
              height = 0.25,
              width = 0.6,
              prompt_position = "bottom",
            },
            prompt_prefix = "󱎸  ",
          },
        },
      }
      require("telescope").load_extension "projects"
    end,
  },
}
