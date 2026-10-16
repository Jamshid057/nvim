return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
        {
            "<leader>tt",
            function()
                require("trouble").toggle("diagnostics")
            end,
            desc = "Toggle diagnostics",
        },
        {
            "[t",
            function()
                require("trouble").next({ mode = "diagnostics", jump = true })
            end,
            desc = "Next Trouble item",
        },
        {
            "]t",
            function()
                require("trouble").prev({ mode = "diagnostics", jump = true })
            end,
            desc = "Previous Trouble item",
        },
    },
}
