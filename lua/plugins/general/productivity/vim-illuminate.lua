-- vim-illuminate.lua - Highlight matching words under cursor
return {
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
      delay = 200,
      -- Don't illuminate in these file types
      filetypes_denylist = {
        "NvimTree",
        "TelescopePrompt",
        "NeogitStatus",
        "lazy",
        "mason",
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "vim-illuminate")
      require("illuminate").configure(opts)
    end,
  },
}
