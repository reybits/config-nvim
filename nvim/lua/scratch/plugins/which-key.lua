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
            return ctx.plugin and 0 or 800
        end,

        -- Inside gitcommit / Neogit-managed buffers, hide global <leader>g…
        -- entries from the popup so it only surfaces buffer-local actions
        -- (e.g. commit-msg's gc / gC). The block_git_globals autocmd installs
        -- buffer-local <Nop> shadows tagged `which_key_ignore`; drop those too
        -- so the popup isn't littered with shadow rows.
        filter = function(mapping)
            local ft = vim.bo.filetype
            if ft ~= "gitcommit" and not ft:find("^Neogit") then
                return true
            end
            if mapping.desc == "which_key_ignore" then
                return false
            end
            if mapping.buffer and mapping.buffer > 0 then
                return true
            end
            local leader = vim.g.mapleader or "\\"
            if mapping.lhs and mapping.lhs:sub(1, #leader + 1) == leader .. "g" then
                return false
            end
            return true
        end,
        spec = {
            mode = { "n", "v" },

            { "<leader>", group = "󰯉" },
            { "<leader>b", group = "Buffer" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "File" },
            { "<leader>g", group = "Git Related" },
            { "<leader>gb", group = "Blame" },
            { "<leader>gh", group = "Hunks" },
            { "<leader>gm", group = "Merge Tool" },
            { "<leader>o", group = "Options" },
            { "<leader>oe", group = "Editor" },
            { "<leader>r", group = "Run" },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Tools" },
            { "<leader>w", group = "Window" },

            { "`", group = "Marks" },
            { "'", group = "Marks" },
            { '"', group = "Registers" },
            { "<c-w>", group = "Window" },
            { "g", group = "Goto" },
            { "gr", group = "LSP" },
            { "z", group = "Folding" },
            { "[", group = "Jump Prev" },
            { "]", group = "Jump Next" },
        },
        icons = {
            mappings = true,
            group = "", -- " ",
            rules = {
                { pattern = "󰯉", icon = "󱁐", color = "cyan" },
                { pattern = "code", icon = "󰅩", color = "cyan" },
                { pattern = "folding", icon = "", color = "cyan" },
                { pattern = "git", icon = "", color = "orange" },
                { pattern = "goto", icon = "󱣱", color = "cyan" },
                { pattern = "jump next", icon = "󰮺", color = "cyan" },
                { pattern = "jump prev", icon = "󰮹", color = "cyan" },
                { pattern = "lazygit", icon = "", color = "orange" },
                { pattern = "marks", icon = "󰍕", color = "cyan" },
                { pattern = "options", icon = "", color = "cyan" },
                { pattern = "run", icon = "", color = "cyan" },
                { pattern = "tools", icon = "", color = "cyan" },
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
