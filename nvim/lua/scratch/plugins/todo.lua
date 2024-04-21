return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local todo = require("todo-comments")
        todo.setup({})

        local map = vim.keymap.set
        -- stylua: ignore
        map("n", "]t", function() todo.jump_next() end, { desc = "Next TODO comment" })
        -- stylua: ignore
        map("n", "[t", function() todo.jump_prev() end, { desc = "Prev TODO comment" })
    end,
}
