return {
    -- lua functions that many plugins use
    { "nvim-lua/plenary.nvim", lazy = true },

    -- UI Component Library for Neovim.
    -- May be I use this UI toolset in the feature.
    -- { "MunifTanjim/nui.nvim", lazy = true },

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
