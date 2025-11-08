-------------------------------------------------------------------------------
-- ToggleOption - A Neovim module for creating toggleable options.
--
-- Author: Andrey Ugolnik
-- License: MIT
-- GitHub: https://github.com/reybits/
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
--    function()                                 -- Current state
--        return vim.wo.wrap
--    end
--    "Option Title",                            -- Option tile used in notifications and descriptions
-- )
--
-- -- Lazy key mapping integration:
--
-- keys = {
--     my_opt:getMappingTable(),
-- },
--
-------------------------------------------------------------------------------

local ToggleOption = {}

--- Updates mapping and its description.
local function updateMapping(obj)
    -- Extend table with custom options.
    local opts = {
        desc = obj:getCurrentDescription(),
    }
    opts = vim.tbl_extend("keep", opts, obj.opts)

    -- Update the key mapping with a new description.
    vim.keymap.set("n", obj:getMapping(), function()
        obj:toggle()
    end, opts)
end

-- TODO: Add support for different modes (normal, visual, etc.)

--- Creates a new ToggleOption object.
--- @param map string Key mapping for the toggle.
--- @param title string Title used as description and notification.
--- @param on_set function Callback function triggered on state change.
--- @param on_get function Callback function that holds the current state.
--- @return table New ToggleOption instance.
function ToggleOption:new(map, on_set, on_get, title)
    local o = {
        map = map or "",
        on_set = on_set,
        on_get = on_get,
        title = title or "Title Undefined",
        opts = {},
    }
    setmetatable(o, self)
    self.__index = self

    -- Update mapping on buffer enter and window enter
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        callback = function()
            updateMapping(o)
        end,
    })

    return o
end

--- Sets custom options that are forwarded to the mapping function.
--- @param opts? table Custom options.
function ToggleOption:setOpts(opts)
    self.opts = opts
end

--- Gets the current state.
--- @return boolean The current state.
function ToggleOption:getState()
    return self.on_get()
end

--- Sets a new state and updates the key mapping.
--- @param state boolean The new state.
--- @param notify? boolean If true, then notify and call on_set.
function ToggleOption:setState(state, notify)
    self.on_set(state)

    notify = notify ~= false

    updateMapping(self)

    if notify == false then
        return
    end

    -- Call the on_set function if defined.

    -- Display a notification about the state change.
    local msg = self.on_get() and (self.title .. " Enabled") or (self.title .. " Disabled")
    ---@diagnostic disable-next-line: missing-fields
    vim.notify(msg, nil, { key = self.title })
end

--- Gets the key mapping.
--- @return string The assigned key mapping.
function ToggleOption:getMapping()
    return self.map
end

--- Gets the current state description.
--- @return function Function that returns the description of the current state.
function ToggleOption:getCurrentDescription()
    -- return function()
    return self.on_get() and ("Disable " .. self.title) or ("Enable " .. self.title)
    -- end
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
    self:setState(not self.on_get())
end

function ToggleOption:getMappingTable()
    return {
        -- mode = "n",
        self:getMapping(),
        self:getToggleFunc(),
        desc = self:getCurrentDescription(),
    }
end

return ToggleOption
