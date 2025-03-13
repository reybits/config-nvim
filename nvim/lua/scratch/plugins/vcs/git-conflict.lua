return {
    "akinsho/git-conflict.nvim",
    version = "*",
    cmd = {
        "GitConflictChooseOurs",
        "GitConflictChooseTheirs",
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
        "GitConflictListQf",
    },
    keys = {
        { "<leader>gco", "<plug>(git-conflict-ours)", desc = "Choose Ours" },
        { "<leader>gct", "<plug>(git-conflict-theirs)", desc = "Choose Theirs" },
        { "<leader>gcb", "<plug>(git-conflict-both)", desc = "Choose Both" },
        { "<leader>gc0", "<plug>(git-conflict-none)", desc = "Choose None" },
        { "[x", "<plug>(git-conflict-prev-conflict)", desc = "Goto Previous Conflict" },
        { "]x", "<plug>(git-conflict-next-conflict)", desc = "Goto Next Conflict" },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>gc", group = "Conflict", icon = "" },
        })
    end,
    opts = {
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,

        -- Command or function to open the conflicts list
        list_opener = "copen",

        -- They must have background color, otherwise the default color will be used
        highlights = {
            incoming = "DiffAdd",
            current = "DiffText",
        },
    },
}
