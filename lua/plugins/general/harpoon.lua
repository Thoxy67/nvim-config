-- harpoon.lua - Quick file/buffer switching
return {
  {
    "ThePrimeagen/harpoon",
    event = "BufEnter",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function(_, opts)
      local map = vim.keymap.set
      local harpoon = require "harpoon"

      harpoon:setup(opts)

      -- Harpoon file management
      map("n", "<M-e>", function()
        harpoon:list():add()
      end, { desc = "Harpoon add buffer" })
      map("n", "<M-r>", function()
        harpoon:list():remove()
      end, { desc = "Harpoon remove buffer" })
      map("n", "<M-q>", function()
        harpoon:list():prev()
      end, { desc = "Harpoon previous buffer" })
      map("n", "<M-w>", function()
        harpoon:list():next()
      end, { desc = "Harpoon next buffer" })

      -- Telescope integration for harpoon list
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      map("n", "<M-t>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Harpoon show list" })
    end,
  },
}
