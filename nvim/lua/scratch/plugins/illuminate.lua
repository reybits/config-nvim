return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure({
            filetypes_denylist = {
                "DiffviewFiles",
                "DressingInput",
                "DressingSelect",
                "Jaq",
                "NeogitCommitMessage",
                "NvimTree",
                "Outline",
                "TelescopePrompt",
                "Trouble",
                "alpha",
                "checkhealth",
                "dirbuf",
                "dirvish",
                "fugitive",
                "fugitiveblame",
                "harpoon",
                "lazy",
                "lir",
                "mason",
                "neo-tree",
                "netrw",
                "qf",
                "spectre_panel",
                "toggleterm",
            },
        })

        local map = vim.keymap.set
        map("n", "<leader>oi", function()
            illuminate.toggle()
            -- stylua: ignore
            print("Illiminate " .. (illuminate.is_paused() and "disabled" or "enabled"))
        end, { desc = "Toggle Illuminate" })

        map("n", "]]", function()
            illuminate.goto_next_reference(true)
        end, { desc = "Goto Next Reference" })

        map("n", "[[", function()
            illuminate.goto_prev_reference(true)
        end, { desc = "Goto Prev Reference" })
    end,
}
