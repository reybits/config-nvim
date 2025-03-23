return {
    "refractalize/oil-git-status.nvim",
    dependencies = {
        "stevearc/oil.nvim",
    },
    opts = {
        symbols = {
            -- Icons from neo-tree.nvim
            --
            -- Change type
            -- added = "✚",
            -- deleted = "✖",
            -- modified = "",
            -- renamed = "󰁕",
            --
            -- Status type
            -- untracked = "",
            -- ignored = "",
            -- unstaged = "󰄱",
            -- staged = "",
            -- conflict = "",

            index = {
                ["!"] = "",
                ["?"] = "",
                ["A"] = "✚",
                ["C"] = "C",
                ["D"] = "✖",
                ["M"] = "",
                ["R"] = "󰁕",
                ["T"] = "T",
                ["U"] = "󰄱",
                [" "] = " ",
            },
            working_tree = {
                ["!"] = "",
                ["?"] = "",
                ["A"] = "✚",
                ["C"] = "C",
                ["D"] = "✖",
                ["M"] = "",
                ["R"] = "󰁕",
                ["T"] = "T",
                ["U"] = "󰄱",
                [" "] = " ",
            },
        },
    },
}
