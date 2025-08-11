return {
  {
    "zongben/proot.nvim",
    cmd = "Proot",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      detector = {
        enable_file_detect = true,
        enable_lsp_detect = true,
      },
      files = { ".git" },
      ignore = {
        subpath = true, --If you are using monorepo, set to true to ignore subrepos
        lsp = nil, -- ignore lsp clients by name e.g. { "pyright", "tsserver" }
      },
      events = {
        entered = function(path)
          vim.cmd "bufdo bd"

          local clients = vim.lsp.get_clients()
          for _, client in pairs(clients) do
            vim.cmd("LspRestart " .. client.name)
          end
        end,
      },
    },
  },
}
