return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame_opts = {
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        },
        current_line_blame_formatter = "<author_time:%Y-%m-%d> <author>: <summary>",
        signs = {
            -- add = { text = "┃" },
            -- change = { text = "┃" },
            delete = { text = "" },
            topdelete = { text = "" },
            -- changedelete = { text = "~" },
            -- untracked = { text = "┆" },
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

            map("n", "<leader>gbb", gitsigns.blame, { desc = "Blame Buffer" })

            map("n", "<leader>gbl", gitsigns.blame_line, { desc = "Blame Line" })
            map("n", "<leader>gbi", gitsigns.toggle_current_line_blame, { desc = "Toggle Blame Inline" })

            -- Diff Buffer
            map("n", "<leader>gd", function() gitsigns.diffthis(nil, { split="botright" }) end, { desc = "Diff Buffer" })

            -- Preview Hunk
            map("n", "<leader>ghp", gitsigns.preview_hunk_inline, { desc = "Preview Hunk" })

            -- Stage/Unstage Hunk
            map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage/Unstage Hunk" })
            map("v", "<leader>ghs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage Hunk" })

            -- Reset Hunk
            map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
            map("v", "<leader>ghr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage Hunk" })
        end,
    },
}
