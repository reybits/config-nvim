return {
    "folke/trouble.nvim",
    lazy = true,
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "folke/todo-comments.nvim",
    },
    keys = {
        {
            "<leader>xx",
            -- "<cmd>Trouble lsp toggle<cr>",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP related (Trouble)",
        },
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xD",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xq",
            -- "<cmd>Trouble quickfix toggle<cr>",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xt",
            "<cmd>Trouble todo toggle<cr>",
            desc = "Todo (Trouble)",
        },
        {
            "<leader>a",
            "<cmd>Trouble symbols toggle focus=true win.position=left<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xr",
            "<cmd>Trouble lsp_references toggle<cr>",
            desc = "References List (Trouble)",
        },
        {
            "<leader>xi",
            "<cmd>Trouble lsp_incoming_calls toggle<cr>",
            desc = "Incoming Calls (Trouble)",
        },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
