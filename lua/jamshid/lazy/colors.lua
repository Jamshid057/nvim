return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- mocha, macchiato, frappe, latte
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false,
                show_end_of_buffer = false,
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false,
                no_bold = false,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = false,
                        indentscope_color = "",
                    },
                },
            })
            -- Default theme - mocha
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
        config = function()
            -- Darcula theme o'rnatilgan, lekin default emas
            -- :colorscheme darcula-solid buyrug'i bilan ishlatish mumkin
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            -- Nightfox theme o'rnatilgan
            -- :colorscheme terafox buyrug'i bilan ishlatish mumkin
        end,
    },
}
