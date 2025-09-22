return {
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    ft = { "markdown", "quarto", "vimwiki" }, -- Load for image-heavy file types
    cmd = { "ImageView" },
    opts = {
      processor = "magick_cli",
    },
    config = function(_, opts)
      require("image").setup(opts)
    end,
  },
}
