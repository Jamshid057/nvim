return {
    {
        'nvim-telescope/telescope.nvim',

        tag = '0.1.6',

        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',  -- Treesitter dependency (ft_to_lang uchun)
        },

        config = function ()
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = { 
                        "venv",
                        "__pycache__",
                        "%.pyc",
                        "%.pyo",
                        "%.pyd",
                        ".git",
                        "node_modules",
                        ".DS_Store",
                    },
                    preview = {
                        -- Treesitter highlighter'ni o'chirish (ft_to_lang muammosi tufayli)
                        treesitter = false,
                    },
                }
            })

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function ()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
