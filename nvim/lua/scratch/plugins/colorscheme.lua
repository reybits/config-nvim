return {
    "EdenEast/nightfox.nvim",
    dependencies = {
        "ellisonleao/gruvbox.nvim",
        "noahfrederick/vim-noctu",
        "nickcharlton/vim-materia",
        { "catppuccin/nvim", name = "catppuccin" },

        "jeffkreeftmeijer/vim-dim", -- ansi colors
    },
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme duskfox]])
        -- vim.cmd([[colorscheme gruvbox]])
        -- vim.cmd([[colorscheme noctu]])
        -- vim.cmd([[colorscheme catppuccin]])

        -- vim.opt.termguicolors = false
        -- vim.cmd([[colorscheme dim]])
    end,
}
