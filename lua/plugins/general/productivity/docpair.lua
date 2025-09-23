return {
  {
    "isticusi/docpair.nvim",
    main = "docpair",
    cmd = { "Documented" },
    opts = { info_filetype = "markdown" },
    config = true, -- calls require("docpair").setup(opts)
  },
}
