return {
    cmd = { "Git", "G" },
    keys = { { "<leader>gs", "<cmd>Git<CR>" } },
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end,
}
