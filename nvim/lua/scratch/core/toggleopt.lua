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
--- @param title string Title used as description and notification.
--- @param state? boolean Initial state (default: false).
--- @return table New ToggleOption instance.
function ToggleOption:new(map, callback, title, state)
    local o = {
        map = map or "",
        callback = callback,
        title = title or "Unkonown Toggle Optioon",
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
--- @param notify? boolean If true, then notify and call callback.
function ToggleOption:setState(state, notify)
    self.state = state
    if notify == nil then
        notify = true
    end

    -- Update the key mapping with a new description.
    vim.keymap.set("n", self:getMapping(), function()
        self:toggle()
    end, { desc = self:getCurrentDescription() })

    if notify == false then
        return
    end

    -- Call the callback function if defined.
    if self.callback ~= nil then
        self.callback(state)
    end

    -- Display a notification about the state change.
    local msg = state and (self.title .. " Enabled") or (self.title .. " Disabled")
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
    return self.state and ("Disable " .. self.title) or ("Enable " .. self.title)
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
