local ToggleOption = require("scratch.core.toggleopt")

local toggle_tscontext = ToggleOption.new({
    map = "<leader>coc",
    title = "TS Context",
    get = function()
        return vim.g.ts_context_enabled == true
    end,
    set = function(state)
        vim.g.ts_context_enabled = state
        if state then
            vim.cmd("TSContext enable")
        else
            vim.cmd("TSContext disable")
        end
    end,
})

return {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    cmd = {
        "TSContext",
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>co", group = "Options" },
        })
    end,
    opts = {
        enable = toggle_tscontext:get(),
        max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        -- separator = "-",
    },
}
