return {
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      auto_resize_height = false,
      preview = {
        auto_preview = false,
      },
    },
    config = function(_, opts)
      require("bqf").setup(opts)
    end,
  },
}
