return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        { "L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" } },
    },
    config = function()
        local cmp = require("cmp")
        local snippets = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        snippets.filetype_extend("python", { "django", "django-rest" })
        snippets.filetype_extend("htmldjango", { "html" })
        require("jakhon.snippets")
        cmp.setup({
            snippet = {
                expand = function(args)
                    snippets.lsp_expand(args.body)
                end,
            },
            window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
            mapping = cmp.mapping.preset.insert({
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif snippets.jumpable(-1) then
                        snippets.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif snippets.expand_or_jumpable() then
                        snippets.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Esc>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources(
                { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "path" } },
                { { name = "buffer" } }
            ),
        })
        cmp.setup.cmdline({ "/", "?" }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
        })
    end,
}
