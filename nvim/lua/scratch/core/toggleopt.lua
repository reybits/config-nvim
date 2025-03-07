-------------------------------------------------------------------------------
-- Author: Andrey Ugolnik
-- Description: A module for creating toggle options in Neovim.
-- License: MIT
-- https://github.com/andreyugolnik/
-------------------------------------------------------------------------------

--- Usage ---------------------------------------------------------------------
---
-- local ToggleOption = require("scratch.core.toggleopt")
--
-- local my_opt = ToggleOption:new(
--    "<leader>ot",
--    "my_option_name",
--    { "Notify Message 1", "Notify Message 2" },
--    { "Description 1", "Description 2" }
-- )
--
-- Lazy key event:
--
-- keys = {
--     {
--         mode = "n",
--         my_opt:getMapping(),
--         my_opt:getToggleFunc(),
--         desc = my_opt:getCurrentDescription(),
--     },
-- },
--
-------------------------------------------------------------------------------

local ToggleOption = {}

function ToggleOption:new(map, option, msg, desc)
    local o = {
        map = map or "",
        option = option or "ERROR",
        msg = msg or { "ERROR", "ERROR" },
        desc = desc or { "ERROR", "ERROR" },
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function ToggleOption:getMapping()
    return self.map
end

function ToggleOption:getState()
    local state = vim.g[self.option] or false
    return state
end

function ToggleOption:setState(state)
    vim.g[self.option] = state
end

function ToggleOption:getCurrentDescription()
    local state = ToggleOption.getState(self)
    local desc = state and self.desc[2] or self.desc[1]
    return desc
end

function ToggleOption:toggle()
    local state = not ToggleOption.getState(self)
    ToggleOption.setState(self, state)

    local updateOption = function(desc)
        vim.keymap.set("n", ToggleOption.getMapping(self), function()
            ToggleOption.toggle(self)
        end, { desc = desc })
    end

    local desc = ToggleOption.getCurrentDescription(self)
    updateOption(desc)

    local msg = state and self.msg[1] or self.msg[2]
    vim.notify(msg, vim.log.levels.INFO)
end

function ToggleOption:getToggleFunc()
    return function()
        ToggleOption.toggle(self)
    end
end

return ToggleOption
