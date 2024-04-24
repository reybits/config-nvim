return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame_opts = {
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        },
        current_line_blame_formatter = "<author_time:%Y-%m-%d> <author>: <summary>",
        current_line_blame_formatter_opts = {
            relative_time = false,
        },
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "~" }, -- { text = "▎" },
            untracked = { text = "┆" }, -- { text = "▎" },
        },
        -- stylua: ignore
        on_attach = function(_)
            local gitsigns = require("gitsigns")
            local map = vim.keymap.set

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, { desc = "Next Hunk" })

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, { desc = "Prev Hunk" })

            -- Hunks related
            map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
            map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
            map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "Unstage Hunk" })
            map("v", "<leader>ghs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage Hunk" })
            map("v", "<leader>ghr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage Hunk" })

            -- Buffer related
            map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
            map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
            map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview Buffer" })

            map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })

            -- Toggle
            map("n", "<leader>gi", gitsigns.toggle_current_line_blame, { desc = "Toggle Blame Inline" })
            map("n", "<leader>go", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

            -- Diff
            map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff Buffer" })

            -- Text object
            map( { "o", "x" }, "ih", ":<c-u>Gitsigns select_hunk<cr>", { desc = "Select Hunk" })
        end,
    },
}
