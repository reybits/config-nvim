--
-- Extensible UI for Neovim notifications and LSP progress messages.
--

local ToggleOption = require("scratch.core.toggleopt")
local helpers = require("scratch.core.helpers")

local toggle_truncate = ToggleOption.new({
    map = "<leader>ot",
    title = "Truncate Notifications",
    get = function()
        return vim.g.fidget_truncate_notifications ~= false
    end,
    set = function(state)
        vim.g.fidget_truncate_notifications = state
    end,
})

return {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
        notification = {
            override_vim_notify = true, -- override vim.notify() with Fidget

            view = {
                stack_upwards = false, -- if true, set `notification.window.align` to "bottom"
                render_message = function(msg, cnt)
                    local message = cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
                    if toggle_truncate:get() then
                        local width = math.floor(vim.o.columns / 2)
                        return helpers.truncate(message, width)
                    end
                    return message
                end,
            },

            window = {
                winblend = 0,
                border = "rounded",
                zindex = 9999,
                align = "top",
                avoid = {
                    "TestExplorer",
                },
            },
        },
    },
}
