return {
    "ibhagwan/fzf-lua",
    dependencies = {
        -- optional for icon support
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "FzfLua",
    -- stylua: ignore
    keys = {
        { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Buffers List" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers List" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Find Recent Files" },
        { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
        { "<leader>ff", function ()
                require('fzf-lua').files({ cwd = vim.fn.expand('%:h') })
            end, desc = "Find Files (cwd)" },

        { "<leader>fC", function ()
                require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
            end, desc = "Find Neovim Files" },

        { "<leader>fP", function ()
                require('fzf-lua').files({ cwd = require('lazy.core.config').options.root })
            end, desc = "Find plugin file" },

        { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Fuzzy Search Buffer" },

        { "<leader>sg", "<cmd>FzfLua grep_project<cr>", desc = "Live Grep" },
        { "<leader>sG", function ()
                require('fzf-lua').grep_project({ cwd = vim.fn.expand('%:h') })
            end, desc = "Live Grep (cwd)" },

        { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep String" },
        { "<leader>sW", function ()
                require('fzf-lua').grep_cword({ cwd = vim.fn.expand('%:h') })
            end, desc = "Grep Word (cwd)" },

        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Find TODO/INFO/..." },

        { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Search Help" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search Keymaps" },
    },
    opts = {
        "telescope",
        winopts = {
            width = 1,
            height = 1,
            preview = {
                layout = "vertical",
                vertical = "up:70%",
            },
        },
    },
}
