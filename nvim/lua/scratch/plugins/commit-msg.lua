return {
    "reybits/commit-msg.nvim",
    ft = "gitcommit",
    cmd = {
        "CommitMsgGen",
        "CommitMsgCancel",
    },
    keys = {
        {
            "<leader>gc",
            "<cmd>CommitMsgGen<cr>",
            ft = "gitcommit",
            desc = "Generate commit message",
        },
        {
            "<leader>gC",
            "<cmd>CommitMsgCancel<cr>",
            ft = "gitcommit",
            desc = "Cancel commit message generation",
        },
    },
    opts = {
        auto = false,
        -- API key is read from env; first non-empty wins.
        api_key_env = { "ANTHROPIC_API_KEY_COMMIT_MSG" },
        model = "claude-haiku-4-5",
        max_tokens = 512,
        -- thinking = { budget_tokens = 1024 },  -- enable extended thinking
    },
}
