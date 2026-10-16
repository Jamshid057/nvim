return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", { "mason-org/mason.nvim", opts = {} } },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "html",
                        "css",
                        "scss",
                        "less",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "json",
                        "jsonc",
                        "yaml",
                        "markdown",
                    },
                    prefer_local = "node_modules/.bin",
                }),
                null_ls.builtins.formatting.djlint.with({ extra_args = { "--profile", "django" } }),
                null_ls.builtins.diagnostics.djlint.with({
                    filetypes = { "htmldjango", "django" },
                    extra_args = { "--profile", "django" },
                }),
            },
        })
    end,
    keys = {
        {
            "<leader>gf",
            function()
                require("jakhon.format").format()
            end,
            desc = "Format buffer",
        },
    },
}
