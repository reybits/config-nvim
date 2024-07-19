return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    opts = {
        -- Delay before showing the popup.
        delay = function(ctx)
            return ctx.plugin and 0 or 500
        end,
        spec = {
            { "<leader>b", group = "Buffer" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "File" },
            { "<leader>g", group = "Git" },
            { "<leader>gh", group = "Hunks" },
            { "<leader>o", group = "Options" },
            { "<leader>s", group = "Search" },
            { "<leader>u", group = "UI" },
            { "<leader>w", group = "Window" },
            { "<leader>x", group = "Diagnostics" },
            { " ", group = "Essential" },
            { "g", group = "Goto" },
            { "z", group = "Folding" },
            { "[", desc = "Jump Prev" },
            { "]", desc = "Jump Next" },
        },
        icons = {
            mappings = true,
            group = "", -- " ",
            rules = {
                { pattern = "options", icon = "", color = "cyan" },
            },
        },
        win = {
            wo = {
                winblend = 10, -- 0 for fully opaque and 100 for fully transparent
            },
        },
        layout = {
            align = "center", -- align columns left, center or right
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
    end,
}
