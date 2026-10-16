return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            direction = "float",
            open_mapping = [[<c-\>]],
            on_create = function(term)
                -- Activate once when a shell starts; reopening keeps its running jobs intact.
                if term.cmd then
                    return
                end
                local origin = require("toggleterm.ui").get_origin_window()
                local buffer = origin and vim.api.nvim_win_is_valid(origin) and vim.api.nvim_win_get_buf(origin)
                local client = buffer and vim.lsp.get_clients({ bufnr = buffer, name = "pyright" })[1]
                local root = client and client.root_dir
                    or (buffer and vim.fs.dirname(vim.api.nvim_buf_get_name(buffer)))
                    or term.dir
                local python = client and client.settings.python and client.settings.python.pythonPath
                    or require("jakhon.python").interpreter(root)
                local environment = vim.fs.dirname(vim.fs.dirname(python))
                local activate = vim.fs.joinpath(environment, "bin", "activate")
                if vim.fn.filereadable(activate) == 1 then
                    term:send(". " .. vim.fn.shellescape(activate))
                end
            end,
            float_opts = {
                border = "curved",
            },
        },
    },
}
