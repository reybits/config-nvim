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
        ---@type false | "classic" | "modern" | "helix"
        preset = "helix",

        -- Delay before showing the popup.
        delay = function(ctx)
            return ctx.plugin and 0 or 500
        end,
        spec = {
            mode = { "n", "v" },

            { " ", group = "Essential" },
            { "<leader>a", group = "AI" },
            { "<leader>b", group = "Buffer" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "File" },
            { "<leader>g", group = "Git Related" },
            { "<leader>gb", group = "Blame" },
            { "<leader>gh", group = "Hunks" },
            { "<leader>o", group = "Options" },
            { "<leader>oc", group = "Code" },
            { "<leader>oe", group = "Editor" },
            { "<leader>r", group = "Run" },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Tools" },
            { "<leader>w", group = "Window" },
            { "<leader>x", group = "Diagnostics" },
            { "g", group = "Goto" },
            { "z", group = "Folding" },

            { "[", group = "Jump Prev" },
            { "]", group = "Jump Next" },
        },
        icons = {
            mappings = true,
            group = "", -- " ",
            rules = {
                { pattern = "code", icon = "󰅩", color = "cyan" },
                { pattern = "options", icon = "", color = "cyan" },
                { pattern = "tools", icon = "", color = "cyan" },
                { pattern = "run", icon = "", color = "cyan" },
                { pattern = "lazygit", icon = "", color = "orange" },
                { pattern = "git", icon = "", color = "orange" },
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
