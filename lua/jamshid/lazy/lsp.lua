return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        -- Barcha LSP'lar uchun UTF-8 position encoding
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "clangd",
                "pyright",
                "ruff",           -- Python linting uchun
                "jsonls",
                "marksman",
                "html",
                "cssls",          -- CSS uchun
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    -- rust_analyzer va ruff_lsp alohida handler'lar bilan ishlaydi
                    if server_name ~= "rust_analyzer" and server_name ~= "ruff_lsp" then
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            offsetEncoding = { "utf-8" },  -- UTF-8 position encoding
                        })
                    end
                end,

                -- ["rust_analyzer"] = function()
                --     local lspconfig = require("lspconfig")
                --     lspconfig.rust_analyzer.setup({
                --         capabilities = capabilities,
                --         settings = {
                --             cargo = {
                --                 features = "all",
                --                 allFeatures = true,
                --             },
                --        }
                --     })
                -- end,
                --

                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        offsetEncoding = { "utf-8" },  -- UTF-8 position encoding
                        root_dir = function(fname)
                            local util = require("lspconfig.util")
                            local root = util.root_pattern(
                                "manage.py",
                                "pyproject.toml",
                                "setup.py",
                                "requirements.txt",
                                ".git"
                            )(fname)
                            return root or util.find_git_ancestor(fname) or vim.fn.getcwd()
                        end,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "off",  -- Type checking o'chirilgan
                                    diagnosticMode = "off",  -- Barcha diagnostic'lar o'chirilgan
                                    useLibraryCodeForTypes = false,
                                    autoSearchPaths = true,
                                    -- Django uchun barcha xatoliklarni o'chirish
                                    diagnosticSeverityOverrides = {
                                        -- Django Meta class xatoliklari
                                        reportIncompatibleVariableOverride = "none",
                                        reportIncompatibleMethodOverride = "none",
                                        reportGeneralTypeIssues = "none",
                                        reportIncompatibleBaseClass = "none",
                                        reportIncompatibleAttributeOverride = "none",
                                        -- Django model field xatoliklari
                                        reportArgumentType = "none",
                                        reportAssignmentType = "none",
                                        reportAttributeAccessIssue = "none",
                                        reportCallIssue = "none",
                                        reportInvalidTypeVarUse = "none",
                                        reportMissingParameterType = "none",
                                        reportMissingTypeArgument = "none",
                                        reportMissingTypeStubs = "none",
                                        reportOperatorIssue = "none",
                                        reportOptionalMemberAccess = "none",
                                        reportOptionalSubscript = "none",
                                        reportPrivateImportUsage = "none",
                                        reportTypeCommentUsage = "none",
                                        reportUnboundVariable = "none",
                                        reportUninitializedInstanceVariable = "none",
                                        reportUnknownArgumentType = "none",
                                        reportUnknownLambdaType = "none",
                                        reportUnknownMemberType = "none",
                                        reportUnknownParameterType = "none",
                                        reportUnknownVariableType = "none",
                                        reportUnnecessaryCast = "none",
                                        reportUnnecessaryComparison = "none",
                                        reportUnnecessaryContains = "none",
                                        reportUnnecessaryIsInstance = "none",
                                        reportUntypedBaseClass = "none",
                                        reportUntypedClassDecorator = "none",
                                        reportUntypedFunctionDecorator = "none",
                                        reportUntypedNamedTuple = "none",
                                        reportUnusedCallResult = "none",
                                        reportUnusedClass = "none",
                                        reportUnusedCoroutine = "none",
                                        reportUnusedException = "none",
                                        reportUnusedFunction = "none",
                                        reportUnusedImport = "none",
                                        reportUnusedVariable = "none",
                                    },
                                    -- Django uchun qo'shimcha sozlamalar
                                    stubPath = vim.fn.expand("~/.config/nvim/stubs"),  -- Django stubs uchun
                                },
                            },
                        },
                        on_attach = function(client, bufnr)
                            -- Pyright formatting'ni o'chirish (Black va isort ishlatamiz)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false

                            -- Pyright diagnostikani to'liq o'chirish (faqat autocomplete uchun)
                            client.handlers["textDocument/publishDiagnostics"] = function() end
                        end,
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        offsetEncoding = { "utf-8" },  -- UTF-8 position encoding
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,

                ["html"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.html.setup({
                        capabilities = capabilities,
                        offsetEncoding = { "utf-8" },  -- UTF-8 position encoding
                        filetypes = { "html", "htmldjango" },  -- Django template uchun
                        settings = {
                            html = {
                                format = {
                                    wrapLineLength = 120,
                                    wrapAttributes = "auto",
                                },
                            },
                        },
                    })
                end,

                ["cssls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.cssls.setup({
                        capabilities = capabilities,
                        offsetEncoding = { "utf-8" },  -- UTF-8 position encoding
                        settings = {
                            css = {
                                validate = true,
                                lint = {
                                    unknownAtRules = "ignore",
                                },
                            },
                        },
                    })
                end,

                ["ruff_lsp"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ruff_lsp.setup({
                        capabilities = capabilities,
                        offsetEncoding = { "utf-8" },  -- UTF-8 position encoding
                        init_options = {
                            settings = {
                                args = {},
                                -- Django-specific Ruff configuration
                                extendSelect = {},
                                ignore = {
                                    "DJ01",  -- Django-specific
                                    "E501",  -- Line too long (handled by formatter)
                                },
                            },
                        },
                        root_dir = function(fname)
                            local util = require("lspconfig.util")
                            local root = util.root_pattern("manage.py", "pyproject.toml", "ruff.toml", ".git")(fname)
                            return root or util.find_git_ancestor(fname) or vim.fn.getcwd()
                        end,
                        on_attach = function(client)
                            -- Ruff LSP faqat linting qiladi, formatting yo'q
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                    })
                end,
            },
        })

        -- cmp.setup() completions.lua da sozlangan, shuning uchun bu yerda kerak emas

        -- Diagnostic ko'rsatish sozlamalari
        vim.diagnostic.config({
            virtual_text = true,   -- Virtual text yoqilgan
            signs = true,          -- Signs yoqilgan
            underline = true,      -- Underline yoqilgan
            update_in_insert = false,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Hover window sozlamalari (K tugmasi uchun)
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "rounded",
                max_width = 80,
                max_height = 20,
            }
        )

        -- Global diagnostika handler - null-ls va pyright diagnostikalarini filter qilish
        local original_diagnostic_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
            -- null-ls va pyright diagnostikalarini filter qilish
            if result and result.diagnostics and ctx and ctx.client_id then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                if client and (client.name == "null-ls" or client.name == "pyright") then
                    -- null-ls va pyright diagnostikalarini o'tkazib yuborish
                    return
                end
            end
            -- Boshqa client'lar (ruff) uchun oddiy handler
            if original_diagnostic_handler then
                original_diagnostic_handler(err, result, ctx, config)
            else
                vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end
        end

        -- Diagnostic hotkeylari
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

        -- LSP client'larni ko'rsatish
        vim.keymap.set("n", "<leader>ls", function()
            local clients = vim.lsp.get_active_clients()
            local count = #clients
            local message = "Ishlayotgan LSP serverlar: " .. count .. "\n\n"
            if count > 0 then
                for _, client in ipairs(clients) do
                    message = message .. "• " .. client.name .. "\n"
                end
            else
                message = message .. "Hech qanday LSP server ishlamayapti"
            end
            vim.notify(message, vim.log.levels.INFO, { title = "LSP Status" })
        end, { desc = "Show active LSP servers" })
    end,
}

--[[
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "tsserver",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                            globals = { "vim", "it", "describe", "before_each", "after_each" },
                        },
                    },
                },
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "crr", vim.lsp.buf.code_action, {})
        end,
    },
}
--]]
