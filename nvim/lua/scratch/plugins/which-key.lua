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
            {
                -- normal mode only
                { "<leader>a", group = "AI" },
                { "<leader>f", group = "File" },
                { "<leader>o", group = "Options" },
                { "<leader>s", group = "Search" },
                { "<leader>w", group = "Window" },
                { "<leader>x", group = "Diagnostics" },
                { "g", group = "Goto" },
            },
            {
                -- normal and visual mode
                mode = { "n", "v" },

                { "<leader>b", group = "Buffer" },
                { "<leader>c", group = "Code" },
                { "<leader>d", group = "Debug" },
                { "<leader>g", group = "Git" },
                { "<leader>gh", group = "Hunks" },
                { " ", group = "Essential" },
                { "z", group = "Folding" },

                { "[", group = "Jump Prev" },
                { "]", group = "Jump Next" },
            },
        },
        icons = {
            mappings = true,
            group = "", -- " ",
            rules = {
                { pattern = "options", icon = "", color = "cyan" },
            },
        },
        win = {
            no_overlap = false, -- don't allow the popup to overlap with the cursor
            wo = {
                winblend = 10, -- 0 for fully opaque and 100 for fully transparent
            },
        },
    },
}
