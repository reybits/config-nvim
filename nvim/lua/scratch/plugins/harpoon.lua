return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Open Harpoon window" })

        vim.keymap.set("n", "<leader>H", function()
            vim.notify("File '" .. vim.fn.expand("%") .. "' added to Harpoon", vim.log.levels.INFO)
            harpoon:list():add()
        end, { desc = "Add file to Harpoon" })

        vim.keymap.set("n", "1", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "2", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "3", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "4", function()
            harpoon:list():select(4)
        end)
        vim.keymap.set("n", "5", function()
            harpoon:list():select(5)
        end)
        vim.keymap.set("n", "6", function()
            harpoon:list():select(6)
        end)
        vim.keymap.set("n", "7", function()
            harpoon:list():select(7)
        end)
        vim.keymap.set("n", "8", function()
            harpoon:list():select(8)
        end)
        vim.keymap.set("n", "9", function()
            harpoon:list():select(9)
        end)

        -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
}
