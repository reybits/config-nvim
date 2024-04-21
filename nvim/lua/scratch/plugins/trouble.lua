return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    -- stylua: ignore
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle (Trouble)" },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diags (Trouble)" },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document diags (Trouble)" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix list (Trouble)" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location list (Trouble)" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location list (Trouble)" },
        { "gr", function() require("trouble").toggle("lsp_references") end, desc = "References list (Trouble)" },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
