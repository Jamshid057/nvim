require("jamshid.remap")
require("jamshid.set")
require("jamshid.lazy_init")


local augroup = vim.api.nvim_create_augroup
local JamshidGroup = augroup('Jamshid', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
	require('plenary.reload').reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = 'templ',
	}
})

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end
})

autocmd({"BufWritePre"}, {
    group = JamshidGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})


autocmd('LspAttach', {
    group = JamshidGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- K tugmasi - hover (function/class haqida ma'lumot ko'rsatadi)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})



