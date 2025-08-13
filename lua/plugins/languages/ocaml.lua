-- ============================================================================
-- OCAML LANGUAGE SUPPORT
-- lua/plugins/languages/ocaml.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Configure OCaml Language Server
lspconfig.ocamllsp.setup {
  on_attach = on_attach,
  filetypes = {
    "ml",
    "mli",
    "cmi",
    "cmo",
    "cmx",
    "cma",
    "cmxa",
    "cmxs",
    "cmt",
    "cmti",
    "opam",
  },
  root_dir = util.root_pattern("merlin.opam", "dune-project"),
  settings = {
    ocamllsp = {
      filetypes = {
        "ocaml",
        "ocaml.menhir", -- Parser generator
        "ocaml.interface", -- Interface files
        "ocaml.ocamllex", -- Lexer generator
        "reason", -- Reason syntax
        "dune", -- Dune build files
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "*.opam", -- Package files
          "esy.json", -- Esy package manager
          "package.json", -- npm compatibility
          ".git", -- Git repository
          "dune-project", -- Dune project file
          "dune-workspace", -- Dune workspace
          "*.ml" -- OCaml source files
        )(fname)
      end,
    },
  },
}

return {
  -- Treesitter support for OCaml
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },
}
