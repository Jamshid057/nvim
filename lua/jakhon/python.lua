local M = {}

local function environment_python(directory)
    if not directory or directory == "" then
        return nil
    end
    for _, relative in ipairs({ "bin/python", "Scripts/python.exe" }) do
        local python = vim.fs.joinpath(directory, relative)
        if vim.fn.executable(python) == 1 then
            return python
        end
    end
end

function M.interpreter(root)
    -- Respect the environment explicitly activated before launching Neovim.
    for _, variable in ipairs({ "VIRTUAL_ENV", "CONDA_PREFIX" }) do
        local python = environment_python(vim.env[variable])
        if python then
            return python, variable
        end
    end
    if root then
        for dir in vim.fs.parents(root .. "/_") do
            for _, name in ipairs({ ".venv", "venv", "env" }) do
                local python = environment_python(vim.fs.joinpath(dir, name))
                if python then
                    return python, "project " .. name
                end
            end
            if vim.uv.fs_stat(vim.fs.joinpath(dir, ".git")) then
                break
            end
        end
    end
    local python = vim.fn.exepath("python3")
    if python == "" then
        python = vim.fn.exepath("python")
    end
    return python ~= "" and python or "python", "PATH"
end

function M.info()
    local client = vim.lsp.get_clients({ bufnr = 0, name = "pyright" })[1]
    local root = client and client.root_dir
        or vim.fs.root(vim.api.nvim_buf_get_name(0), {
            "pyrightconfig.json",
            "pyproject.toml",
            "manage.py",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            ".git",
        })
        or vim.fn.getcwd()
    local selected, source = M.interpreter(root)
    local python = client and client.settings.python and client.settings.python.pythonPath or selected
    local lines = {
        "Project: " .. root,
        "VIRTUAL_ENV: " .. (vim.env.VIRTUAL_ENV or "aktiv emas"),
        "CONDA_PREFIX: " .. (vim.env.CONDA_PREFIX or "aktiv emas"),
        "Detected Python (" .. source .. "): " .. selected,
        "Pyright Python: " .. (client and python or "hali ulanmagan"),
    }
    local code = [[
import importlib.util, sys
print("Interpreter: " + sys.executable)
print("Environment: " + sys.prefix)
for name in ("django", "rest_framework", "fastapi"):
    spec = importlib.util.find_spec(name)
    print(name + ": " + (str(spec.origin) if spec else "NOT INSTALLED in this environment"))
]]
    vim.system(
        { python, "-c", code },
        { text = true },
        vim.schedule_wrap(function(result)
            lines[#lines + 1] = result.code == 0 and result.stdout or (result.stderr or "Python ishga tushmadi")
            vim.notify(
                table.concat(lines, "\n"),
                result.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR,
                { title = "Python environment" }
            )
        end)
    )
end

function M.setup()
    vim.api.nvim_create_user_command(
        "PythonInfo",
        M.info,
        { desc = "Show active environment, Pyright interpreter and framework availability", force = true }
    )
end

return M
