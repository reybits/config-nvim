return {
    "folke/ts-comments.nvim",
    -- event = "VeryLazy",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    enabled = vim.fn.has("nvim-0.10.0") == 1,
    opts = {},
}
