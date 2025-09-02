-- proot.lua - Project root detection and management
return {
  {
    "zongben/proot.nvim",
    cmd = "Proot",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      "<leader>fP",
      "<cmd>Proot<CR>",
      mode = { "n" },
      desc = "Open project explorer (Proot)",
    },
    opts = {
      detector = {
        enable_file_detect = true, -- Detect project by files
        enable_lsp_detect = true, -- Detect project by LSP
      },
      files = { ".git" }, -- Files that indicate project root
      ignore = {
        subpath = true, -- Ignore subrepos in monorepos
        lsp = nil, -- Ignore specific LSP clients
      },
      events = {
        -- What to do when entering a new project
        entered = function(path)
          vim.cmd "bufdo bd" -- Close all buffers

          -- Restart LSP clients for new project
          local clients = vim.lsp.get_clients()
          for _, client in pairs(clients) do
            vim.cmd("LspRestart " .. client.name)
          end
        end,
      },
    },
  },
}
