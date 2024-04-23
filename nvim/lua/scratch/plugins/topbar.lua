return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = "tabs",
                always_show_bufferline = false,
                -- stylua: ignore
                close_command = function(n) require("mini.bufremove").delete(n, false) end,
                -- stylua: ignore
                right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                color_icons = false,
                show_buffer_close_icons = false,
                enforce_regular_tabs = true,
            },
        })
    end,
}
