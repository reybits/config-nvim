return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame_opts = {
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        },
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        -- stylua: ignore
        on_attach = function(_)
            local map = vim.keymap.set;
            map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff buffer" })
            map("n", "<leader>gi", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle blame Inline" })
        end,
    },
}
