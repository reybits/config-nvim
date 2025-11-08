local ToggleOption = require("scratch.core.toggleopt")

local toggle_tscontext = ToggleOption:new("<leader>coc", function(state)
    vim.g.ts_context_enabled = state
    if state then
        vim.cmd("TSContext enable")
    else
        vim.cmd("TSContext disable")
    end
end, function()
    return vim.g.ts_context_enabled == true
end, "TS Context")

return {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    cmd = {
        "TSContext",
    },
    keys = {
        toggle_tscontext:getMappingTable(),
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>co", group = "Options" },
        })
    end,
    opts = {
        enable = toggle_tscontext:getState(),
        max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        -- separator = "-",
    },
}
