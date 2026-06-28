-------------------------------------------------------------------------------
-- ToggleOption - Toggleable Neovim options with which-key-aware live labels.
--
-- Author: Andrey Ugolnik
-- License: MIT
-- GitHub: https://github.com/reybits/
--
-- Usage:
--   local ToggleOption = require("scratch.core.toggleopt")
--
--   ToggleOption.new({
--       map = "<leader>ow",
--       title = "Wrap",
--       get = function() return vim.wo.wrap end,
--       set = function(state) vim.wo.wrap = state end,
--       -- buffer = bufnr,   -- optional, for buffer-local registration
--       -- silent = true,    -- optional, forwarded to vim.keymap.set
--       -- mode   = "n",     -- optional, defaults to "n"
--       -- notify = false,   -- optional, suppress the "X Enabled / Disabled" notify
--   })
-------------------------------------------------------------------------------

--- @class scratch.ToggleOption.Spec
--- @field map string         Key mapping lhs.
--- @field title string       Label used in the keymap desc and notifications.
--- @field get fun():boolean  Returns the current state.
--- @field set fun(state: boolean)  Applies a new state.
--- @field buffer? integer    Buffer number for buffer-local registration.
--- @field silent? boolean    Forwarded to vim.keymap.set.
--- @field mode? string       Keymap mode (default: "n").
--- @field notify? boolean    If false, no notification on state change.

--- @class scratch.ToggleOption
--- @field toggle fun(self)
--- @field set    fun(self, state: boolean)
--- @field get    fun(self): boolean

local ToggleOption = {}

local function describe(spec)
    return spec.get() and ("Disable " .. spec.title) or ("Enable " .. spec.title)
end

--- Create and register a toggleable option.
--- @param spec scratch.ToggleOption.Spec
--- @return scratch.ToggleOption
function ToggleOption.new(spec)
    assert(type(spec) == "table", "ToggleOption.new: spec must be a table")
    assert(type(spec.map) == "string" and spec.map ~= "", "ToggleOption.new: spec.map is required")
    assert(type(spec.title) == "string", "ToggleOption.new: spec.title is required")
    assert(type(spec.get) == "function", "ToggleOption.new: spec.get is required")
    assert(type(spec.set) == "function", "ToggleOption.new: spec.set is required")

    local mode = spec.mode or "n"
    local self = {}

    function self:get()
        return spec.get()
    end

    function self:set(state)
        spec.set(state)
        if spec.notify == false then
            return
        end
        local msg = spec.get() and (spec.title .. " Enabled") or (spec.title .. " Disabled")
        vim.notify(msg, vim.log.levels.INFO, { key = spec.title })
    end

    function self:toggle()
        self:set(not spec.get())
    end

    vim.keymap.set(mode, spec.map, function()
        self:toggle()
    end, {
        desc = describe(spec),
        buffer = spec.buffer,
        silent = spec.silent,
    })

    -- which-key's function desc is re-evaluated on every popup, so the label
    -- tracks the live state without any autocmd. `real = true` drops the
    -- entry from the popup automatically if the underlying keymap is gone
    -- (e.g. nothing replaced this global when LSP detaches a buffer-local).
    --
    -- The defer is needed because spec files under `scratch.plugins/` evaluate
    -- alphabetically during lazy.setup(); files starting with letters before
    -- "w" run before lazy registers which-key.nvim, so require("which-key")
    -- fails right now. Scheduling postpones the call to the next event-loop
    -- tick, after lazy.setup() has finished registering every spec.
    vim.schedule(function()
        pcall(function()
            require("which-key").add({
                {
                    spec.map,
                    mode = mode,
                    desc = function()
                        return describe(spec)
                    end,
                    buffer = spec.buffer,
                    real = true,
                },
            })
        end)
    end)

    return self
end

return ToggleOption
