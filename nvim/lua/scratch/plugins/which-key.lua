return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
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
            { "<leader>b", group = "Buffer", mode = { "n", "v" } },
            { "<leader>c", group = "Code", mode = { "n", "v" } },
            { "<leader>d", group = "Debug", mode = { "n", "v" } },
            { "<leader>f", group = "File" },
            { "<leader>g", group = "Git", mode = { "n", "v" } },
            { "<leader>gh", group = "Hunks", mode = { "n", "v" } },
            { "<leader>o", group = "Options" },
            { "<leader>s", group = "Search" },
            { "<leader>u", group = "UI" },
            { "<leader>w", group = "Window" },
            { "<leader>x", group = "Diagnostics" },
            { " ", group = "Essential", mode = { "n", "v" } },
            { "g", group = "Goto" },
            { "z", group = "Folding", mode = { "n", "v" } },
            { "[", desc = "Jump Prev", mode = { "n", "v" } },
            { "]", desc = "Jump Next", mode = { "n", "v" } },
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
}
