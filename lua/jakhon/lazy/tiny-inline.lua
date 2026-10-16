return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    config = function()
        require("tiny-inline-diagnostic").setup({ preset = "modern" })
        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            signs = true,
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
    end,
}
