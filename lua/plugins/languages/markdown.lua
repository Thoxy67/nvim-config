-- ============================================================================
-- Markdown LANGUAGE SUPPORT
-- lua/plugins/languages/v.lua
-- ============================================================================

vim.filetype.add {
  extension = { mdx = "markdown.mdx" },
}

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Configure V Language Analyzer
lspconfig.marksman.setup {
  on_attach = on_attach,
  filetypes = { "markdown", "markdown.mdx" },
  root_dir = util.root_pattern "README.md",
  settings = {},
}

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find "<!%-%- toc %-%->" then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.markdownlint_cli2,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  {
    "nvim-treesitter",
    lazy = false,
    priority = 49,
    dependencies = {
      "saghen/blink.cmp",
      {
        "OXY2DEV/markview.nvim",
        opts = {
          preview = {
            hybrid_modes = { "n" }, -- Show preview in normal mode
            icon_provider = "devicons", -- Use devicons for file type icons
          },
          html = {
            enable = true,
          },
          markdown_inline = {
            enable = true,
          },
        },
        config = function()
          dofile(vim.g.base46_cache .. "markview")
        end,
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load { plugins = { "markdown-preview.nvim" } }
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   opts = {
  --     code = {
  --       sign = false,
  --       width = "block",
  --       right_pad = 1,
  --     },
  --     heading = {
  --       sign = false,
  --       icons = {},
  --     },
  --     checkbox = {
  --       enabled = false,
  --     },
  --   },
  --   ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  --   config = function(_, opts)
  --     require("render-markdown").setup(opts)
  --   end,
  -- },
}
