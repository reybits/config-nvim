return {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "folke/todo-comments.nvim",
    },
    -- stylua: ignore
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble" },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diags" },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diags" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
        { "gr", "<cmd>lua require('trouble').toggle('lsp_references')<cr>", desc = "References List" },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
