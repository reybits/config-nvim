local ToggleOption = require("scratch.core.toggleopt")

local toggle_tscontext = ToggleOption:new("<leader>occ", function(state)
    if state then
        vim.cmd("TSContextEnable")
    else
        vim.cmd("TSContextDisable")
    end
end, "TS Context", false) -- disable ts context by default

return {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    cmd = {
        "TSContextEnable",
        "TSContextDisable",
        "TSContextToggle",
    },
    keys = {
        {
            toggle_tscontext:getMapping(),
            toggle_tscontext:getToggleFunc(),
            desc = toggle_tscontext:getCurrentDescription(),
        },
    },
    opts = {
        enable = false,
        max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        -- separator = "-",
    },
}
