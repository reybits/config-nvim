return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    -- stylua: ignore
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "[TRBL] Toggle" },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[TRBL] Workspace Diags" },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[TRBL] Document Diags" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "[TRBL] Quickfix List" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "[TRBL] Location List" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "[TRBL] Location List" },
        { "gr", function() require("trouble").toggle("lsp_references") end, desc = "[TRBL] References List" },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
