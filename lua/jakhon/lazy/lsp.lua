return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config("*", { capabilities = capabilities })

        vim.lsp.config("pyright", {
            root_markers = {
                "pyrightconfig.json",
                "pyproject.toml",
                "manage.py",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                ".git",
            },
            before_init = function(_, config)
                config.settings = config.settings or {}
                config.settings.python = config.settings.python or {}
                config.settings.python.pythonPath = require("jakhon.python").interpreter(config.root_dir)
            end,
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                    },
                },
            },
        })
        vim.lsp.config("ruff", {
            root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "manage.py", ".git" },
            on_attach = function(client)
                -- Pyright owns hover/type information; Ruff owns lint and formatting.
                client.server_capabilities.hoverProvider = false
            end,
        })
        vim.lsp.config("html", {
            filetypes = { "html", "htmldjango" },
            root_markers = { "package.json", "manage.py", "pyproject.toml", ".git" },
            get_language_id = function(_, filetype)
                return filetype == "htmldjango" and "html" or filetype
            end,
        })
        vim.lsp.config("cssls", { filetypes = { "css", "scss", "less" } })
        vim.lsp.config("clangd", {
            cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
        })
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
                    telemetry = { enable = false },
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "ruff", "html", "cssls", "ts_ls", "clangd", "jsonls", "lua_ls", "marksman" },
            automatic_enable = { exclude = { "rust_analyzer" } },
        })
        require("jakhon.tools").setup()
    end,
}
