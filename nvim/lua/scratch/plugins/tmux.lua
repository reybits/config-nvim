return {
    -- TMUX companion plugin:
    -- https://github.com/christoomey/vim-tmux-navigator
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    -- stylua: ignore
    keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Goto Left Window" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Goto Down Window" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Goto Up Window" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Goto Right Window" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Previous Window" },
    },
}
