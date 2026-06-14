return {
    "reybits/commit-msg.nvim",
    ft = "gitcommit",
    cmd = {
        "CommitMsgGen",
        "CommitMsgCancel",
    },
    opts = {
        -- API key is read from env; first non-empty wins.
        api_key_env = { "ANTHROPIC_API_KEY_COMMIT_MSG" },
        model = "claude-haiku-4-5",
        max_tokens = 512,
        -- thinking = { budget_tokens = 1024 },  -- enable extended thinking
    },
}
