return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		
		-- Python virtual environment detection
		local function get_python_executable()
			local venv_paths = { ".venv", "venv", "env", "virtualenv" }
			local root = vim.fn.getcwd()
			
			for _, venv_name in ipairs(venv_paths) do
				local venv_python = root .. "/" .. venv_name .. "/bin/python"
				if vim.fn.executable(venv_python) == 1 then
					return venv_python
				end
			end
			
			-- Fallback to system python
			return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
		end
		
		local python_exec = get_python_executable()
		
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				-- Python formatting (venv ichida ishlatish)
				null_ls.builtins.formatting.black.with({
					command = python_exec,
					args = { "-m", "black", "--quiet", "--fast", "-" },
					condition = function()
						return vim.fn.executable(python_exec) == 1
					end,
				}),
				null_ls.builtins.formatting.isort.with({
					command = python_exec,
					args = { "-m", "isort", "--stdout", "--profile", "black", "-" },
					condition = function()
						return vim.fn.executable(python_exec) == 1
					end,
				}),
				-- Django formatting (diagnostika olib tashlangan)
				null_ls.builtins.formatting.djhtml.with({
					command = python_exec,
					filetypes = { "htmldjango", "django" },
					condition = function()
						return vim.fn.executable(python_exec) == 1
					end,
				}),
				-- djlint diagnostikasini olib tashlash (faqat formatting uchun)
			},
		})
		
		-- null-ls diagnostikalarini o'chirish (faqat formatting uchun)
		-- LspAttach event'da null-ls diagnostikalarini yashirish
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(e)
				local client = vim.lsp.get_client_by_id(e.data.client_id)
				if client and client.name == "null-ls" then
					-- null-ls diagnostikalarini yashirish
					client.handlers["textDocument/publishDiagnostics"] = function() end
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
