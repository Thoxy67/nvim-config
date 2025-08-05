local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")


-- Change this to 'bacon-ls' if you want to use for diagnostics
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

local diagnostics = vim.g.lazyvim_rust_diagnostics == 'rust-analyzer'

if vim.g.lazyvim_rust_diagnostics == "bacon-ls" then
    lspconfig.bacon_ls.setup({
        on_attach = on_attach,
        settings = {
            -- bacon_ls specific settings
        }
    })
end

vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = on_attach,
        root_dir = util.root_pattern("Cargo.toml", 'build.rs', "main.rs", "lib.rs", ".git"),
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    buildScripts = {
                        enable = true,
                    },
                },
                -- Add clippy lints for Rust if using rust-analyzer
                checkOnSave = diagnostics == "rust-analyzer",
                -- Enable diagnostics if using rust-analyzer
                diagnostics = {
                    enable = diagnostics == "rust-analyzer",
                },
                procMacro = {
                    enable = true,
                    ignored = {
                        ["async-trait"] = { "async_trait" },
                        ["napi-derive"] = { "napi" },
                        ["async-recursion"] = { "async_recursion" },
                    },
                },
                files = {
                    excludeDirs = {
                        ".direnv",
                        ".git",
                        ".github",
                        ".gitlab",
                        "bin",
                        "node_modules",
                        "target",
                        "venv",
                        ".venv",
                    },
                },
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}

-- lspconfig.rust_analyzer.setup({
--     on_attach = on_attach,
--     -- rust_analyzer specific settings
-- })

return {
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = function(_, opts)
            local crates = require "crates"

            vim.keymap.set("n", "<leader>cu", function()
                crates.upgrade_all_crates()
            end, { desc = "Update crates" })

            local options = {
                completion = {
                    crates = {
                        enabled = true,
                    },
                    -- cmp = {
                    --     enabled = false,
                    -- },
                },
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            }

            opts = vim.tbl_deep_extend("force", opts or {}, options)
            return opts
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "rust", "ron" } },
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
        config = function(_, opts)
            -- Check if mason.nvim is available and codelldb is installed
            local mason_ok, mason_registry = pcall(require, "mason-registry")
            if mason_ok then
                local codelldb_ok, codelldb_pkg = pcall(mason_registry.get_package, "codelldb")
                if codelldb_ok and codelldb_pkg:is_installed() then
                    -- Use the newer API with vim.fn.expand and $MASON environment variable
                    local package_path = vim.fn.expand("$MASON/packages/codelldb/extension/")
                    local codelldb = package_path .. "adapter/codelldb"
                    local library_path = package_path .. "lldb/lib/liblldb.dylib"
                    local uname = io.popen("uname"):read("*l")
                    if uname == "Linux" then
                        library_path = package_path .. "lldb/lib/liblldb.so"
                    end
                    opts.dap = {
                        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
                    }
                end
            end

            vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

            if vim.fn.executable("rust-analyzer") == 0 then
                vim.notify(
                    "rust-analyzer not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
                    vim.log.levels.ERROR,
                    { title = "rustaceanvim" }
                )
            end
        end,
    },
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
            local registry = require("mason-registry")
            if not registry.is_installed("codelldb") then
                registry.get_package("codelldb"):install()
            end
            if vim.g.lazyvim_rust_diagnostics == "bacon-ls" then
                if not registry.is_installed("bacon") then
                    registry.get_package("bacon"):install()
                end
                if not registry.is_installed("bacon-ls") then
                    registry.get_package("bacon-ls"):install()
                end
            end
        end
    },
    {
        "nvim-neotest/neotest",
        optional = true,
        opts = {
            adapters = {
                ["rustaceanvim.neotest"] = {},
            },
        },
    },
}
