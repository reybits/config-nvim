return {
    "folke/todo-comments.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next TODO comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Prev TODO comment",
        },
    },
    opts = {},
}
