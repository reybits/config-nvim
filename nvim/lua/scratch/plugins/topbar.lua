return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = "tabs",
                always_show_bufferline = false,
                color_icons = false,
                show_buffer_close_icons = false,
                enforce_regular_tabs = true,
            },
        })
    end,
}
