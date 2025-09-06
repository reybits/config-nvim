return {
    "samoshkin/vim-mergetool",
    keys = {
        { "<leader>gmm", "<cmd>MergetoolToggle<cr>", desc = "Toggle Mergetool" },
        { "<leader>gmn", "<cmd>MergetoolNextConflict<cr>", desc = "Next Conflict" },
        { "<leader>gmp", "<cmd>MergetoolPrevConflict<cr>", desc = "Previous Conflict" },
    },
    init = function()
        -- In case of rebase branch FEATURE onto branch MASTER:
        -- B is the common ancestor of branches FEATURE and MASTER (base)
        -- R is the version from branch FEATURE (remote)
        -- L is the version from branch MASTER (local)
        -- M is the version that git has auto-merged (if possible)
        vim.g.mergetool_layout = "BR,M"
    end,
}
