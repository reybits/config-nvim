--- Blink-cmp source for CopilotChat completions (@agents, /prompts, #resources, $models).

local M = {}

function M.new()
    return setmetatable({}, { __index = M })
end

function M:enabled()
    return package.loaded["CopilotChat"] ~= nil and vim.bo.filetype == "copilot-chat"
end

function M:get_trigger_characters()
    return { "@", "/", "#", "$" }
end

function M:get_completions(context, callback)
    local info = require("CopilotChat.completion").info()
    local cursor_before = context.line:sub(1, context.cursor[2])
    local prefix, cmp_start = unpack(vim.fn.matchstrpos(cursor_before, info.pattern))

    if not prefix or prefix == "" then
        callback()
        return
    end

    local range = {
        start = { line = context.cursor[1] - 1, character = cmp_start },
        ["end"] = { line = context.cursor[1] - 1, character = context.cursor[2] },
    }

    require("plenary.async").run(function()
        return require("CopilotChat.completion").items()
    end, function(items)
        local result = {}
        for _, item in ipairs(items) do
            if vim.startswith(item.word:lower(), prefix:lower()) then
                table.insert(result, {
                    label = item.abbr or item.word,
                    insertText = item.word,
                    kind = require("blink.cmp.types").CompletionItemKind.Text,
                    textEdit = { range = range, newText = item.word },
                    labelDetails = {
                        description = item.menu or "",
                        detail = item.kind or "",
                    },
                    documentation = item.info and #item.info > 0
                            and { value = item.info, kind = "plaintext" }
                        or nil,
                })
            end
        end

        callback({
            is_incomplete_forward = true,
            is_incomplete_backward = true,
            items = result,
        })
    end)
end

return M
