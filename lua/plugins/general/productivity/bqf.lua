return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_resize_height = true,
      preview = {
        auto_preview = false,
      },
    },
    config = function(_, opts)
      require("bqf").setup(opts)
    end,
  },
}
