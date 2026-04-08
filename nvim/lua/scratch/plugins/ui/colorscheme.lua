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

local setupWinSeparator = function()
    -- Set custom highlight for window separator.
    -- It improves visibility of split windows.
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#aaaa00" })
end

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("kanagawa").setup({
                compile = false,
                transparent = true,
                -- dimInactive = true,
            })

            vim.cmd("colorscheme kanagawa-dragon")
            setupWinSeparator()
        end,
        build = ":KanagawaCompile",
    },

    --[[
    {
        "EdenEast/nightfox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("duskfox", "vim")
        end,
    },

    {
        -- "ellisonleao/gruvbox.nvim", -- doesn't support 16/256 colors terminal
        "morhetz/gruvbox",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("gruvbox", "vim")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd("colorscheme catppuccin-mocha")
            setupWinSeparator()
        end,
    },

    -- ansi colors (clone of Vim’s default colorscheme)
    {
        "jeffkreeftmeijer/vim-dim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("dim", "vim")
        end,
    },

    --  for 16-color terminals
    {
        "noahfrederick/vim-noctu",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("noctu", "vim")
        end,
    },

    --  for 16-color terminals
    {
        "nickcharlton/vim-materia",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            setupscheme("interrobang", "vim")
        end,
    },
    --]]
}
