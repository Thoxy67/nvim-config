-- icons.lua - Icon support
return {
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = {
      "DaikyXendo/nvim-material-icon",
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    config = function(_, opts)
      require("mini.icons").setup(opts)
    end,
  },
  {},
  { "chrisbra/unicode.vim", cmd = { "UnicodeSearch" } },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = "Nerdy",
    opts = {
      max_recents = 30, -- Configure recent icons limit
      add_default_keybindings = true, -- Add default keybindings
      copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
    },
  },
  {
    "allaman/emoji.nvim",
    version = "1.0.0", -- optionally pin to a tag
    ft = "markdown", -- adjust to your needs
    dependencies = {
      -- util for handling paths
      "nvim-lua/plenary.nvim",
      -- optional for telescope integration
      "nvim-telescope/telescope.nvim",
      -- optional for fzf-lua integration via vim.ui.select
      "ibhagwan/fzf-lua",
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      enable_cmp_integration = true,
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      -- optional for telescope integration
      require("telescope").load_extension "emoji"
    end,
  },
}
