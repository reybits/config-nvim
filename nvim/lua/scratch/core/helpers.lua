-------------------------------------------------------------------------------
-- Neovim Helper Module
--
-- Author: Andrey Ugolnik
-- License: MIT
-- GitHub: https://github.com/reybits/
--
-- Description:
-- This module provides various utility functions for Neovim, including:
-- - A collection of icons for diagnostics, git, and LSP kinds.
-- - String manipulation utilities (truncation, word splitting).
-- - Custom formatting for completion menu items.
-- - Safe value retrieval and lookup functions.
-- - Table dumping for debugging.
--
-- Features:
-- - Predefined icon sets for UI elements.
-- - String processing functions (truncate, split).
-- - Custom completion formatting for `nvim-cmp`.
-- - Safe value checking and table lookup functions.
-- - Debugging utilities for dumping table contents.
--
-------------------------------------------------------------------------------

local M = {}

--- Predefined icons for debugging, git, diagnostics, and LSP.
M.icons = {
    dap = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = { " ", "DiagnosticInfo", "" },
        BreakpointCondition = { " ", "DiagnosticInfo", "" },
        BreakpointRejected = { " ", "DiagnosticError", "" },
        LogPoint = { ".>", "DiagnosticInfo", "" },
    },
    diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    },
    git = {
        added = " ",
        modified = " ",
        removed = " ",
    },
    kinds = {
        Array = " ",
        Boolean = " ",
        Cody = "󰥖 ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    },
}

--- Truncates a string to a maximum length, keeping both ends.
--- @param line string The string to be truncated.
--- @param max_length number The maximum allowed length.
--- @return string The truncated string with an ellipsis if needed.
M.truncateLine = function(line, max_length)
    local content_length = vim.fn.strcharlen(line)
    if content_length <= max_length then
        return line
    end

    local ELLIPSIS = "…"
    local half_length = math.floor(max_length / 2)
    local tail_length = (max_length - half_length) - vim.fn.strcharlen(ELLIPSIS)

    local left = vim.fn.strcharpart(line, 0, half_length)
    local right = vim.fn.strcharpart(line, content_length - tail_length, tail_length)

    return left .. ELLIPSIS .. right
end

--- Truncates a string to a maximum length, keeping both ends.
--- @param content string The string to be truncated.
--- @param max_length number The maximum allowed length.
--- @return string The truncated string with an ellipsis if needed.
M.truncate = function(content, max_length)
    if not content then
        return ""
    end

    local result = ""

    for n, line in ipairs(vim.split(content, "\n")) do
        result = result .. (result and "\n" or "") .. M.truncateLine(line, max_length)
    end

    return result
end

--- Custom formatter for nvim-cmp completion menu.
--- @param _ any Unused parameter.
--- @param item table The completion item to format.
--- @return table The formatted completion item.
M.cmp_format = function(_, item)
    local icon = M.icons.kinds[item.kind] or " "

    item.kind = "" -- Hide the text kind

    -- Get the width of the current window.
    local columns = vim.o.columns

    -- use truncated `item.word` as `item.abbr`
    item.abbr = icon .. M.truncate(item.word, math.floor(columns * 0.2))
    item.word = ""

    -- truncate `item.menu` too
    item.menu = M.truncate(item.menu, math.floor(columns * 0.35))

    return item
end

--- Splits a string into an array of substrings of a maximum length.
--- @param message string The input string.
--- @param max_length number The maximum length per line.
--- @return table A list of split strings.
M.split_to_strings = function(message, max_length)
    local result = {}
    local row = ""
    local rowLen = 0

    for word in message:gmatch("%S+") do
        local wordLen = #word
        if rowLen + wordLen < max_length then
            row = row .. word .. " "
            rowLen = rowLen + wordLen + 1
        else
            table.insert(result, row)
            row = word .. " "
            rowLen = wordLen + 1
        end
    end

    if row ~= "" then
        table.insert(result, row)
    end

    return result
end

--- Dumps a Lua table or value into a readable string format.
--- @param o any The object to dump.
--- @param depth number The depth of recursion (not implemented).
--- @return string A string representation of the object.
M.dump = function(o, depth)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            local key = type(k) == "number" and k or ('"' .. k .. '"')
            s = s .. "[" .. key .. "] = " .. M.dump(v, depth - 1) .. ", "
        end
        return s .. "} "
    end

    return tostring(o)
end

--- Safely returns a value or a default if the value is nil.
--- @param v any The value to check.
--- @param d any The default value to return if `v` is nil.
--- @return any The original value or the default.
M.safe = function(v, d)
    if v ~= nil then
        return v
    end

    return d ~= nil and d or ""
end

--- Checks if a string contains any substring from a list.
--- @param str string The string to search in.
--- @param list table A table of substrings to look for.
--- @return boolean True if any substring is found, otherwise false.
M.lookup = function(str, list)
    if not str then
        return false
    end

    for _, v in pairs(list) do
        if string.find(str, v) then
            return true
        end
    end

    return false
end

return M
