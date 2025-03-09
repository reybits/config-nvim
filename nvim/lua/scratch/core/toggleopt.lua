-------------------------------------------------------------------------------
-- ToggleOption - A Neovim module for creating toggleable options.
--
-- Author: Andrey Ugolnik
-- License: MIT
-- GitHub: https://github.com/andreyugolnik/
--
-- Description:
-- This module provides a simple way to define toggleable options with key
-- mappings, notifications, and descriptions. It allows users to easily
-- manage options that switch between two states (e.g., enabling/disabling
-- a feature).
--
-- Features:
-- - Define custom toggle options with a key binding.
-- - Automatically update key descriptions.
-- - Display notifications on state changes.
-- - Provide a toggle function for easy integration with lazy loading.
--
-- Usage:
--
-- local ToggleOption = require("scratch.core.toggleopt")
--
-- local my_opt = ToggleOption:new(
--    "<leader>ot",                              -- Key mapping
--    function(state)                            -- Callback function
--        print("Option state: " .. tostring(state))
--    end,
--    { "Feature Enabled", "Feature Disabled" }, -- Notification messages
--    { "Enable Feature", "Disable Feature" },   -- Descriptions
--    state                                      -- Initial state (default: false).
-- )
--
-- -- Lazy key mapping integration:
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

--- Creates a new ToggleOption object.
--- @param map string Key mapping for the toggle.
--- @param callback function Callback function triggered on state change.
--- @param msg table Notification messages {enabled, disabled}.
--- @param desc table Descriptions for the states {disabled, enabled}.
--- @param state boolean Initial state (default: false).
--- @return table New ToggleOption instance.
function ToggleOption:new(map, callback, msg, desc, state)
    local o = {
        map = map or "",
        callback = callback,
        msg = msg or { "ERROR", "ERROR" },
        desc = desc or { "ERROR", "ERROR" },
        state = state or false,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

--- Gets the current state.
--- @return boolean The current toggle state (true = enabled, false = disabled).
function ToggleOption:getState()
    return self.state
end

--- Sets a new state and updates the key mapping.
--- @param state boolean The new state.
function ToggleOption:setState(state)
    self.state = state

    -- Call the callback function if defined.
    if self.callback ~= nil then
        self.callback(state)
    end

    -- Function to update the key mapping with a new description.
    local function updateOption(desc)
        vim.keymap.set("n", self:getMapping(), function()
            self:toggle()
        end, { desc = desc })
    end

    -- Get the updated description for the current state.
    local desc = self:getCurrentDescription()
    updateOption(desc)

    -- Display a notification about the state change.
    local msg = state and self.msg[1] or self.msg[2]
    vim.notify(msg)
end

--- Gets the key mapping.
--- @return string The assigned key mapping.
function ToggleOption:getMapping()
    return self.map
end

--- Gets the current state description.
--- @return string The description of the current state.
function ToggleOption:getCurrentDescription()
    return self.state and self.desc[2] or self.desc[1]
end

--- Returns a function that toggles the state.
--- Useful for key mappings.
--- @return function A function that toggles the state.
function ToggleOption:getToggleFunc()
    return function()
        self:toggle()
    end
end

--- Toggles the state between enabled and disabled.
function ToggleOption:toggle()
    self:setState(not self.state)
end

return ToggleOption
