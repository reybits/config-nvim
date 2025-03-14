--
-- Extensible UI for Neovim notifications and LSP progress messages.
--

local ToggleOption = require("scratch.core.toggleopt")

local toggle_truncte = ToggleOption:new("<leader>ot", nil, "Truncate Notifications", true)

return {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    keys = {
        {
            toggle_truncte:getMapping(),
            toggle_truncte:getToggleFunc(),
            desc = toggle_truncte:getCurrentDescription(),
        },
    },
    opts = {
        notification = {
            override_vim_notify = true, -- override vim.notify() with Fidget

            view = {
                stack_upwards = false, -- if true, set `notification.window.align` to "bottom"
                render_message = function(msg, cnt)
                    local message = cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
                    if toggle_truncte:getState() then
                        local width = math.floor(vim.api.nvim_win_get_width(0) / 3)
                        return require("scratch.core.helpers").truncate(message, width)
                    end
                    return message
                end,
            },

            window = {
                winblend = 80,
                zindex = 9999,
                align = "top",
            },
        },
    },
}
