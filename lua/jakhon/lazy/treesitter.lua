return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- Keep the configs API used by the existing lockfile.
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "bash",
                "python",
                "html",
                "htmldjango",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "c",
                "cpp",
                "json",
                "yaml",
                "toml",
                "markdown",
                "markdown_inline",
                "rust",
            },
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true, disable = { "python" } },
        })
    end,
}
