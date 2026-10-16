local M = {}

function M.format()
    local filetype = vim.bo.filetype
    local preferred = ({ python = "ruff", c = "clangd", cpp = "clangd", rust = "rust-analyzer" })[filetype] or "null-ls"
    local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" })
    for _, client in ipairs(clients) do
        if client.name == preferred then
            vim.lsp.buf.format({ id = client.id, async = false, timeout_ms = 5000 })
            return
        end
    end
    vim.notify("Formatter tayyor emas: " .. preferred .. ". :LspInfo va :Mason ni tekshiring.", vim.log.levels.WARN)
end

return M
