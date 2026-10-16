local M = {}
M.packages = {
    "pyright",
    "ruff",
    "html-lsp",
    "css-lsp",
    "typescript-language-server",
    "clangd",
    "json-lsp",
    "lua-language-server",
    "marksman",
    "stylua",
    "prettier",
    "djlint",
}

function M.ready(package)
    return package:is_installed() and package:get_receipt():is_present() and not package:is_installing()
end

function M.install()
    local registry = require("mason-registry")
    registry.refresh(vim.schedule_wrap(function(success)
        if not success then
            vim.notify(
                "Mason registry yangilanmadi. :MasonToolsInstall bilan qayta urinib ko‘ring.",
                vim.log.levels.ERROR
            )
            return
        end
        for _, name in ipairs(M.packages) do
            local ok, package = pcall(registry.get_package, name)
            if ok and not M.ready(package) and not package:is_installing() then
                package:install():once(
                    "closed",
                    vim.schedule_wrap(function()
                        if not package:get_receipt():is_present() then
                            vim.notify(
                                "Mason: " .. name .. " o‘rnatilmadi. :MasonLog ni tekshiring.",
                                vim.log.levels.ERROR
                            )
                        end
                    end)
                )
            end
        end
    end))
end

function M.setup()
    vim.api.nvim_create_user_command(
        "MasonToolsInstall",
        M.install,
        { desc = "Install configured language servers and formatters", force = true }
    )
    local registry = require("mason-registry")
    for _, name in ipairs(M.packages) do
        local ok, package = pcall(registry.get_package, name)
        if not ok or not M.ready(package) then
            M.install()
            break
        end
    end
end

return M
