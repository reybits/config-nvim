return {
    -- "ellisonleao/gruvbox.nvim",
    "EdenEast/nightfox.nvim",
    -- "catppuccin/nvim", name = "catppuccin",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- load the colorscheme here
        -- vim.cmd([[colorscheme gruvbox]])
        vim.cmd([[colorscheme duskfox]])
        -- vim.cmd([[colorscheme catppuccin]])
    end,
}
