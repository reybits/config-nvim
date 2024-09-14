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
            "<cmd>Trouble todo toggle filter.buf=0<cr>",
            desc = "Buffer Todo (Trouble)",
        },
        {
            "<leader>xT",
            "<cmd>Trouble todo toggle<cr>",
            desc = "Todo (Trouble)",
        },
        {
            "<leader>xa",
            "<cmd>Trouble symbols toggle focus=true win.position=left<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xx",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP related (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble lsp_document_symbols toggle<cr>",
            desc = "LSP Symbols (Trouble)",
        },
        {
            "<leader>xr",
            "<cmd>Trouble lsp_references toggle focus=true<cr>",
            desc = "LSP References (Trouble)",
        },
        {
            "<leader>xi",
            "<cmd>Trouble lsp_incoming_calls toggle focus=true<cr>",
            desc = "LSP Incoming Calls (Trouble)",
        },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
