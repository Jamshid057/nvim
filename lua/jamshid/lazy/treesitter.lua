return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    priority = 1000,  -- Yuqori priority (avval yuklanishi uchun)
    config = function()
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            -- Agar birinchi marta yuklanmasa, qayta urinib ko'rish
            vim.defer_fn(function()
                local retry_ok, retry_configs = pcall(require, "nvim-treesitter.configs")
                if retry_ok then
                    retry_configs.setup({
                        ensure_installed = {
                            "vimdoc",
                            "javascript",
                            "typescript",
                            "c",
                            "lua",
                            "rust",
                            "jsdoc",
                            "bash",
                            "python",
                            "html",
                            "css",
                        },
                        sync_install = false,
                        auto_install = true,
                        indent = { enable = true },
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = { "markdown" },
                        },
                        sync_install = false,
                        auto_install = true,
                        indent = { enable = true },
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = { "markdown" },
                        },
                    })
                end
            end, 100) -- 100ms delay
            return
        end

        configs.setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "lua",
                "rust",
                "jsdoc",
                "bash",
                "python",
                "html",
                "css",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true,
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end,
}
