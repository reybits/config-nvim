return {
    -- Heuristically set buffer options, like tpope's plugin "tpope/vim-sleuth",
    "nmac427/guess-indent.nvim",
    event = {
        "InsertEnter",
    },
    cmd = {
        "GuessIndent",
    },
    opts = {},
}
