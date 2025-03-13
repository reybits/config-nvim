return {
    -- Use Snacks instead of Dressing, as Dressing is no longer supported
    -- Enable only the input and picker modules to replace vim.ui.input and vim.ui.select
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        input = {
            enabled = true,
        },
        picker = {
            enabled = true,
        },

        bigfile = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },

    --[[
    "stevearc/dressing.nvim",
    opts = {
        input = {
            enabled = true,
        },
        select = {
            enabled = true,
            fzf_lua = {
                winopts = {
                    height = 0.5,
                    width = 0.5,
                    row = 0.5,
                    col = 0.5,
                },
            },
        },
    },
    --]]
}
