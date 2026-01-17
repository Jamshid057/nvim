return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            padding = true,
            sticky = true,
            ignore = "^$",
            toggler = {
                line = "gcc",  -- Normal mode: qatorni komment qilish/olib tashlash
                block = "gbc", -- Normal mode: block komment qilish/olib tashlash
            },
            opleader = {
                line = "gc",   -- Visual mode: qatorni komment qilish/olib tashlash
                block = "gb",  -- Visual mode: block komment qilish/olib tashlash
            },
            extra = {
                above = "gcO", -- Qator ustiga komment qo'shish
                below = "gco", -- Qator ostiga komment qo'shish
                eol = "gcA",   -- Qator oxiriga komment qo'shish
            },
            mappings = {
                basic = true,
                extra = true,
            },
            pre_hook = nil,
            post_hook = nil,
        })
    end,
}
