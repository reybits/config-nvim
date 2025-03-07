-------------------------------------------------------------------------------
-- Author: Andrey Ugolnik
-- Description: A module with helper functions for Neovim.
-- License: MIT
-- https://github.com/andreyugolnik/
-------------------------------------------------------------------------------

local M = {}

-- most icons copied from LazyVim plugin
local icons = {
    dap = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = ".>",
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

M.icons = icons

--------------------------------------------------------------------------------

M.truncate = function(content, max_length)
    local truncated = content

    if content ~= nil then
        local content_length = vim.fn.strcharlen(content)
        if content_length > max_length then
            local ELLIPSIS_CHAR = "…" -- "•"
            local ELLIPSIS_LENGTH = vim.fn.strcharlen(ELLIPSIS_CHAR)
            -- truncated = vim.fn.strcharpart(content, 0, max_length - ELLIPSIS_LENGTH)
            --     .. ELLIPSIS_CHAR
            local half_length = math.floor(max_length / 2)
            local tail_length = (max_length - half_length) - ELLIPSIS_LENGTH
            local left = vim.fn.strcharpart(content, 0, half_length)
            local right = vim.fn.strcharpart(content, content_length - tail_length, tail_length)
            truncated = left .. ELLIPSIS_CHAR .. right
            -- else
            --     truncated = content .. (" "):rep(max_length - content_length)
        end
    end

    return truncated
end

--- custom cmp format function -------------------------------------------------
M.cmp_format = function(_, item)
    local icon = icons.kinds[item.kind] or " "

    item.kind = "" -- icon .. item.kind

    -- Get the width of the current window.
    local columns = vim.o.columns -- vim.api.nvim_win_get_width(0)

    -- use truncated `item.word` as `item.abbr`
    item.abbr = icon .. M.truncate(item.word, math.floor(columns * 0.2))
    item.word = ""

    -- truncate `item.menu` too
    item.menu = M.truncate(item.menu, math.floor(columns * 0.35))

    return item
end

--- split message by words into strings array ----------------------------------
M.split_to_strings = function(message, max_length)
    local result = {}
    local row = ""
    local rowLen = 0

    for word in message:gmatch("%S+") do
        local wordLen = word:len()
        if rowLen + wordLen < max_length then
            row = row .. word .. " "
            rowLen = rowLen + wordLen + 1
        else
            table.insert(result, row)
            row = word .. " "
            rowLen = wordLen + 1
        end
    end

    if row:len() ~= 0 then
        table.insert(result, row)
    end

    return result
end

--- simple dumper --------------------------------------------------------------
M.dump = function(o, depth)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. M.dump(v, depth - 1) .. ","
        end
        return s .. "} "
    end

    return tostring(o)
end

--- check v for nil ------------------------------------------------------------
M.safe = function(v, d)
    if v ~= nil then
        return v
    end

    return d ~= nil and d or ""
end

--- lookup substring in the list -----------------------------------------------
M.lookup = function(str, table)
    if str == nil then
        return false
    end

    for _, v in pairs(table) do
        if string.find(str, v) ~= nil then
            return true
        end
    end

    return false
end

return M
