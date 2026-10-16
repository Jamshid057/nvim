local group = vim.api.nvim_create_augroup("Jakhon", { clear = true })

vim.filetype.add({ extension = { templ = "templ" } })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 80 })
    end,
})

-- Django templates retain their template tags during formatting.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    pattern = "*.html",
    callback = function(event)
        local path = vim.api.nvim_buf_get_name(event.buf)
        local django_project = vim.fs.root(path, { "manage.py" })
        local text = table.concat(vim.api.nvim_buf_get_lines(event.buf, 0, 100, false), "\n")
        if django_project or text:find("{%") or text:find("{{") then
            vim.bo[event.buf].filetype = "htmldjango"
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
        "html",
        "css",
        "scss",
        "less",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "yaml",
    },
    callback = function(event)
        vim.bo[event.buf].tabstop = 2
        vim.bo[event.buf].softtabstop = 2
        vim.bo[event.buf].shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "python", "htmldjango" },
    callback = function(event)
        vim.bo[event.buf].tabstop = 4
        vim.bo[event.buf].softtabstop = 4
        vim.bo[event.buf].shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function(event)
        if
            vim.bo[event.buf].buftype ~= ""
            or not vim.bo[event.buf].modifiable
            or vim.bo[event.buf].filetype == "markdown"
        then
            return
        end
        local view = vim.fn.winsaveview()
        vim.cmd([[keepjumps keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        -- Preserve the existing navigation directions as well as the keys.
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts)
    end,
})
