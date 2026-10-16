return {
    {
        "nvim-telescope/telescope.nvim",
        keys = { "<leader>ff", "<C-p>", "<leader>ps" },
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "^%.venv/",
                        "/%.venv/",
                        "^venv/",
                        "/venv/",
                        "__pycache__/",
                        "node_modules/",
                        "%.pyc$",
                    },
                },
                extensions = {
                    ["ui-select"] = require("telescope.themes").get_dropdown({}),
                },
            })

            require("telescope").load_extension("ui-select")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<C-p>", builtin.git_files)
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({
                    search = vim.fn.input("Grep > "),
                })
            end)
        end,
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
}
