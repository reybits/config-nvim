return {
    "EdenEast/nightfox.nvim",
    dependencies = {
        -- { "ellisonleao/gruvbox.nvim" },
        -- { "catppuccin/nvim", name = "catppuccin" },

        --  for 16-color terminals
        -- { "noahfrederick/vim-noctu" },
        -- { "nickcharlton/vim-materia" },

        -- ansi colors (clone of Vim’s default colorscheme)
        { "jeffkreeftmeijer/vim-dim" },
    },
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        local lookup = function(str, table)
            for _, v in pairs(table) do
                if string.find(str, v) ~= nil then
                    return true
                end
            end
            return false
        end

        if
            lookup(vim.env.TERM, { "256" })
            or lookup(vim.env.COLORTERM, { "truecolor" })
        then
            vim.opt.termguicolors = true
            vim.cmd([[colorscheme duskfox]])
            -- vim.cmd([[colorscheme gruvbox]])
            -- vim.cmd([[colorscheme catppuccin]])
        else
            vim.opt.termguicolors = false
            -- vim.cmd([[colorscheme noctu]])
            -- vim.cmd([[colorscheme interrobang]])
            vim.cmd([[colorscheme dim]])
        end
    end,
}
