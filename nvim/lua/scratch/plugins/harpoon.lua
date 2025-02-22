return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local extensions = require("harpoon.extensions")

        -- Highlight current file in the harpoon buffer list
        harpoon:extend(extensions.builtins.highlight_current_file())

        -- Goto buffer by number keys
        harpoon:extend(extensions.builtins.navigate_with_number())

        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Open Harpoon window" })

        vim.keymap.set("n", "<leader>H", function()
            vim.notify("File '" .. vim.fn.expand("%") .. "' added to Harpoon", vim.log.levels.INFO)
            harpoon:list():add()
        end, { desc = "Add file to Harpoon" })

        -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
}
