return {
    "ruifm/gitlinker.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            mode = { "n" },
            "<leader>gy",
            function()
                require("gitlinker.actions").get_buf_range_url("n")
            end,
            desc = "Copy Link for Line",
        },
        {
            mode = { "v" },
            "<leader>gy",
            function()
                require("gitlinker.actions").get_buf_range_url("v")
            end,
            desc = "Copy Link for Range",
        },
    },
    opts = {
        mappings = nil,
    },
}
