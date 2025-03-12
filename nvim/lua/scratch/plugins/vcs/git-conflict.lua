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
        { "co", "<plug>(git-conflict-ours)", desc = "Choose Ours" },
        { "ct", "<plug>(git-conflict-theirs)", desc = "Choose Theirs" },
        { "cb", "<plug>(git-conflict-both)", desc = "Choose Both" },
        { "c0", "<plug>(git-conflict-none)", desc = "Choose None" },
        { "[x", "<plug>(git-conflict-prev-conflict)", desc = "Goto Previous Conflict" },
        { "]x", "<plug>(git-conflict-next-conflict)", desc = "Goto Next Conflict" },
    },
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
