return {
    "folke/trouble.nvim",
    lazy = true,
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "folke/todo-comments.nvim",
    },
    -- stylua: ignore
    keys = {
        -- { "<leader>xx", "<cmd>Trouble<cr>", desc = "Trouble" },
        { "<leader>xx", "<cmd>Trouble lsp toggle<cr>", desc = "Full LSP" },
        { "<leader>xs", "<cmd>Trouble lsp_document_symbols toggle<cr>", desc = "Symbols" },
        { "<leader>xi", "<cmd>Trouble lsp_incoming_calls toggle<cr>", desc = "Incoming Calls" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
        { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix List" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
        { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo" },
        { "gr", "<cmd>Trouble lsp_references toggle<cr>", desc = "References List" },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
