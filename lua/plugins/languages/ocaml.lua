local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

lspconfig.ocamllsp.setup {
  on_attach = on_attach,
  filetypes = { "ml", "mli", "cmi", "cmo", "cmx", "cma", "cmxa", "cmxs", "cmt", "cmti", "opam" },
  root_dir = util.root_pattern("merlin.opam", "dune-project"),
  settings = {
    ocamllsp = {
      filetypes = {
        "ocaml",
        "ocaml.menhir",
        "ocaml.interface",
        "ocaml.ocamllex",
        "reason",
        "dune",
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "*.opam",
          "esy.json",
          "package.json",
          ".git",
          "dune-project",
          "dune-workspace",
          "*.ml"
        )(fname)
      end,
    },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },
}
