return {
    -- Extensible UI for Neovim notifications and LSP progress messages.
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
        notification = {
            -- Automatically override vim.notify() with Fidget
            override_vim_notify = true,
            view = {
                stack_upwards = false, -- if true, set align to 'bottom'
            },
            window = {
                winblend = 0,
                zindex = 9999,
                align = "top",
            },
        },
    },
}
