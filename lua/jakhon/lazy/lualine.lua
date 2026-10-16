return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "dracula",
            },
            sections = {
                lualine_c = { { "filename", path = 3 } },
            },
        })
    end,
}
