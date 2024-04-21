return {
    -- lua functions that many plugins use
    {
        "nvim-lua/plenary.nvim",
    },

    -- measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    --[[ {
        "folke/neoconf.nvim",
        cmd = "Neoconf"
    },

    {
        "folke/neodev.nvim",
        -- opts = {}

        config = function()
            -- dont run neodev.setup
            vim.lsp.start({
                name = "lua-language-server",
                cmd = { "lua-language-server" },
                before_init = require("neodev.lsp").before_init,
                root_dir = vim.fn.getcwd(),
                settings = { Lua = {} },
            })
        end,
    }, ]]
}
