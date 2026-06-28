--[[
local exclude_filetypes = {
    "aerial",
    "alpha",
    "dashboard",
    "help",
    "lazy",
    "lazyterm",
    "mason",
    "neo-tree",
    "notify",
    "nvimtree",
    "oil",
    "oil_preview",
    "toggleterm",
    "trouble",
}
--]]

local ToggleOption = require("scratch.core.toggleopt")

ToggleOption.new({
    map = "<leader>oeg",
    title = "Indent Guides",
    get = function()
        return vim.g.blink_indent_enabled ~= false
    end,
    set = function(state)
        vim.g.blink_indent_enabled = state
        require("blink.indent").enable(state)
    end,
})

return {
    "saghen/blink.indent",
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    config = function()
        local indent = require("blink.indent")
        indent.setup({
            static = {
                char = "╎", -- "┋", "│",
            },
            scope = {
                char = "╎",
                highlights = { "BlinkIndentYellow" },
            },
        })
        indent.enable(vim.g.blink_indent_enabled ~= false)
    end,
}
