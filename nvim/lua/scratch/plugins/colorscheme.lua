return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        dependencies = {},
        config = function()
            local lookup = require("scratch.core.helpers").lookup
            if lookup(vim.env.TERM, { "256" }) or lookup(vim.env.COLORTERM, { "truecolor" }) then
                vim.opt.termguicolors = true
                vim.cmd([[colorscheme duskfox]])
                -- vim.cmd([[colorscheme gruvbox]])
                -- vim.cmd([[colorscheme catppuccin]])
            else
                vim.opt.termguicolors = false
                vim.cmd([[colorscheme vim]])
                -- vim.cmd([[colorscheme noctu]])
                -- vim.cmd([[colorscheme interrobang]])
                -- vim.cmd([[colorscheme dim]])
            end
        end,
    },

    {
        -- "ellisonleao/gruvbox.nvim", -- doesn't support 16/256 colors terminal
        "morhetz/gruvbox",
        lazy = true,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
    },

    -- ansi colors (clone of Vim’s default colorscheme)
    {
        "jeffkreeftmeijer/vim-dim",
        lazy = true,
    },

    --  for 16-color terminals
    {
        "noahfrederick/vim-noctu",
        lazy = true,
    },

    --  for 16-color terminals
    {
        "nickcharlton/vim-materia",
        lazy = true,
    },

    {
        "sphamba/smear-cursor.nvim",
        opts = {
            stiffness = 0.8, -- 0.6 [0, 1]
            trailing_stiffness = 0.5, -- 0.3 [0, 1]
            distance_stop_animating = 0.5, -- 0.1 [>0]
        },
    },
}
