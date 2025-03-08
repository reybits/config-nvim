return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("dashboard").setup({
            theme = "hyper",
            config = {
                disable_move = false, -- default is false disable move keymap for hyper
                week_header = {
                    enable = true,
                },
                project = {
                    -- enable = false,
                    limit = 5,
                    icon = " ",
                    label = "Browse Files in Directory",
                    action = "DashFiles cwd=",
                },
                mru = {
                    limit = 10,
                    icon = " ",
                    label = "Most Recent Files (current dir)",
                    cwd_only = true,
                },
                shortcut = {
                    {
                        icon = " ", -- " 󱉯 "
                        desc = "Sessions",
                        group = "Number", --"@property",
                        action = "SessionsList",
                        key = "s",
                    },
                    {
                        icon = " ", -- "󱉯  "
                        desc = "Restore",
                        group = "Number", --"@property",
                        action = "SessionReadLast",
                        key = "r",
                    },
                    {
                        icon = "󰡦 ", -- " 󰉺  ",
                        desc = "Files",
                        group = "Label",
                        action = "DashFiles",
                        key = "f",
                    },
                    {
                        icon = "󰔠 ", -- "󱑍  ",
                        desc = "Recent",
                        group = "Label",
                        action = "DashRecent",
                        key = "o",
                    },
                    {
                        icon = "󱘢 ", -- " ",
                        desc = "Grep",
                        group = "Label",
                        action = "DashGrep",
                        key = "g",
                    },
                    {
                        icon = " ", -- " 󰊳 ",
                        desc = "Lazy",
                        group = "@property",
                        action = "Lazy",
                        key = "l",
                    },
                },
            },
        })
    end,
}
