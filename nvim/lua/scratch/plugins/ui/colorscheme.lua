local setupscheme = function(theme, fallback)
    local lookup = require("scratch.core.helpers").lookup
    if lookup(vim.env.TERM, { "256" }) or lookup(vim.env.COLORTERM, { "truecolor" }) then
        vim.opt.termguicolors = true
        vim.cmd("colorscheme " .. theme)
    else
        vim.opt.termguicolors = false
        vim.cmd("colorscheme " .. fallback)
    end
end

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("kanagawa").setup({
                compile = false,
            })

            setupscheme("kanagawa-wave", "vim")
        end,
        build = ":KanagawaCompile",
    },

    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("duskfox", "vim")
        end,
    },

    --[[
    {
        -- "ellisonleao/gruvbox.nvim", -- doesn't support 16/256 colors terminal
        "morhetz/gruvbox",
        lazy = true,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("gruvbox", "vim")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("catppuccin", "vim")
        end,
    },

    -- ansi colors (clone of Vim’s default colorscheme)
    {
        "jeffkreeftmeijer/vim-dim",
        lazy = true,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("dim", "vim")
        end,
    },

    --  for 16-color terminals
    {
        "noahfrederick/vim-noctu",
        lazy = true,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("noctu", "vim")
        end,
    },

    --  for 16-color terminals
    {
        "nickcharlton/vim-materia",
        lazy = true,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("interrobang", "vim")
        end,
    },
    --]]
}
