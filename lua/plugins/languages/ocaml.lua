-- ============================================================================
-- OCAML LANGUAGE SUPPORT
-- lua/plugins/languages/ocaml.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Configure OCaml Language Server
vim.lsp.config.ocamllsp = {
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
  root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace", "*.ml" },
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
