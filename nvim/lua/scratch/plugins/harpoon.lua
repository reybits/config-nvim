return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>h",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Open Harpoon window",
        },
        {
            "<leader>H",
            function()
                vim.notify(
                    "File '" .. vim.fn.expand("%") .. "' added to Harpoon",
                    vim.log.levels.INFO
                )
                require("harpoon"):list():add()
            end,
            desc = "Add file to Harpoon",
        },
        --[[
        {
            "<leader>P",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Toggle previous buffers stored within Harpoon list",
        },
        {
            "<leader>N",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Toggle next buffers stored within Harpoon list",
        },
        --]]
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local extensions = require("harpoon.extensions")

        -- Highlight current file in the harpoon buffer list
        harpoon:extend(extensions.builtins.highlight_current_file())

        -- Goto buffer by number keys
        harpoon:extend(extensions.builtins.navigate_with_number())
    end,
}
