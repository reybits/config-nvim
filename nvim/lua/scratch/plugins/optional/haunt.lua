--
-- Ghost text bookmarks for Neovim
--
return {
    "TheNoeTrevino/haunt.nvim",
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>h", group = "Haunt" },
        })
    end,
    config = function()
        local haunt = require("haunt.api")
        local map = vim.keymap.set
        local prefix = "<leader>h"

        -- annotations
        map("n", prefix .. "a", function()
            haunt.annotate()
        end, { desc = "Annotate" })

        map("n", prefix .. "t", function()
            haunt.toggle_annotation()
        end, { desc = "Toggle annotation" })

        map("n", prefix .. "T", function()
            haunt.toggle_all_lines()
        end, { desc = "Toggle all annotations" })

        map("n", prefix .. "d", function()
            haunt.delete()
        end, { desc = "Delete bookmark" })

        map("n", prefix .. "C", function()
            haunt.clear_all()
        end, { desc = "Delete all bookmarks" })

        -- move
        map("n", prefix .. "p", function()
            haunt.prev()
        end, { desc = "Previous bookmark" })

        map("n", prefix .. "n", function()
            haunt.next()
        end, { desc = "Next bookmark" })

        -- picker
        map("n", prefix .. "l", function()
            require("haunt.picker").show()
        end, { desc = "Show Hauntings" })

        -- quickfix
        map("n", prefix .. "q", function()
            haunt.to_quickfix()
        end, { desc = "Send Hauntings to QF Lix (buffer)" })

        map("n", prefix .. "Q", function()
            haunt.to_quickfix({ current_buffer = true })
        end, { desc = "Send Hauntings to QF Lix (all)" })

        -- yank
        map("n", prefix .. "y", function()
            haunt.yank_locations({ current_buffer = true })
        end, { desc = "Send Hauntings to Clipboard (buffer)" })

        map("n", prefix .. "Y", function()
            haunt.yank_locations()
        end, { desc = "Send Hauntings to Clipboard (all)" })
    end,
}
