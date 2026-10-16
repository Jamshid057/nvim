return {
    {
        "briones-gabriel/darcula-solid.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            "rktjmp/lush.nvim",
        },
        config = function()
            vim.cmd("colorscheme darcula-solid")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        config = function()
            --            vim.cmd.colorscheme("terafox")
        end,
    },
}
