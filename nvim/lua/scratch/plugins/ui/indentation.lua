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

local indent_toggle = ToggleOption:new("<leader>oeg", function(state)
    vim.g.blink_indent_enabled = state
    local indent = require("blink.indent")
    indent.enable(state)
end, function()
    return vim.g.blink_indent_enabled ~= false
end, "Indent Guides")

return {
    "saghen/blink.indent",
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    keys = {
        indent_toggle:getMappingTable(),
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
