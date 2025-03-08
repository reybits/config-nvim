return {
    -- lua functions that many plugins use
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    -- Neovim plugin for locking a buffer to a window.
    {
        "stevearc/stickybuf.nvim",
        opts = {},
    },

    -- Minimal Eye-candy keys screencaster
    {
        "nvzone/showkeys",
        cmd = "ShowkeysToggle",
        opts = {
            winopts = {
                focusable = false,
                style = "minimal",
                border = "single",
                zindex = 1000,
            },
            timeout = 1, -- in secs
            maxkeys = 5,
            show_count = true,
        },
    },

    --[[
    -- UI Component Library for Neovim.
    -- May be I use this UI toolset in the feature.
    {
        "MunifTanjim/nui.nvim",
        lazy = true
    },
    --]]

    -- measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    --[[
    -- Neovim plugin to manage global and project-local settings.
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf"
    },
    --]]
}
