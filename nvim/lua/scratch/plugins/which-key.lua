return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        plugins = {
            spelling = true,
        },
        operators = {
            gc = "Comments",
            gb = "Comments",
        },
        icons = {
            -- breadcrumb = "»",
            -- separator = "➜",
            group = " ",
        },
        window = {
            winblend = 20, -- 0 for fully opaque and 100 for fully transparent
        },
        layout = {
            align = "center", -- align columns left, center or right
        },
        defaults = {
            ["<leader>b"] = { name = "Buffer" },
            ["<leader>c"] = { name = "Code" },
            ["<leader>d"] = { name = "Debug" },
            ["<leader>f"] = { name = "File" },
            ["<leader>g"] = { name = "Git" },
            ["<leader>gh"] = { name = "Hunks" },
            ["<leader>o"] = { name = "Options" },
            ["<leader>s"] = { name = "Search" },
            ["<leader>u"] = { name = "UI" },
            ["<leader>w"] = { name = "Window" },
            ["<leader>x"] = { name = "Diagnostics" },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
}
