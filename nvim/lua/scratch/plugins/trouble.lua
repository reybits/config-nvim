return {
    "folke/trouble.nvim",
    lazy = true,
    cmd = {
        "Trouble",
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "folke/todo-comments.nvim",
    },
    keys = {
        {
            "<leader>q",
            -- "<cmd>Trouble quickfix toggle<cr>",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List",
        },
        {
            "<leader>Q",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List",
        },

        {
            "<leader>st",
            "<cmd>Trouble todo toggle filter.buf=0 focus=true<cr>",
            desc = "TODOs",
        },
        {
            "<leader>sT",
            "<cmd>Trouble todo toggle focus=true<cr>",
            desc = "TODOs (workspace)",
        },

        {
            "<leader>co",
            "<cmd>Trouble lsp_document_symbols toggle focus=true win.position=left<cr>",
            desc = "Code Outline",
        },
        -- {
        --     "<leader>cs",
        --     "<cmd>Trouble symbols toggle focus=true win.position=left<cr>",
        --     desc = "Symbols",
        -- },
        {
            "<leader>cr",
            "<cmd>Trouble lsp_references toggle focus=true<cr>",
            desc = "References",
        },
        {
            "<leader>ci",
            "<cmd>Trouble lsp_incoming_calls toggle focus=true<cr>",
            desc = "Incoming Calls",
        },

        {
            "<leader>cx",
            "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
            desc = "LSP related",
        },

        {
            "<leader>cd",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Diagnostics",
        },
        {
            "<leader>cD",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (workspace)",
        },
    },
    config = function()
        require("trouble").setup({
            use_diagnostic_signs = true,
            win = {
                wo = {
                    signcolumn = "no",
                    colorcolumn = "",
                },
            },
        })

        -- Open Trouble quickfix on :copen
        vim.api.nvim_create_autocmd("BufRead", {
            callback = function(ev)
                if vim.bo[ev.buf].buftype == "quickfix" then
                    vim.schedule(function()
                        vim.cmd([[cclose]])
                        vim.cmd([[Trouble qflist open]])
                    end)
                end
            end,
        })

        -- Automatically open Trouble quickfix
        vim.api.nvim_create_autocmd("QuickFixCmdPost", {
            callback = function()
                vim.cmd([[Trouble qflist open]])
            end,
        })
    end,
}
