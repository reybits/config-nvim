return {
    "kdheepak/lazygit.nvim",
    enabled = false,
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim", -- optional for floating window border decoration
    },
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit (project)" },
        { "<leader>lG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (cwd)" },
        { "<leader>ll", "<cmd>LazyGitLog<cr>", desc = "LazyGit Log (project)" },
        { "<leader>lf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Filter (project)" },
        { "<leader>lF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Filter Current File" },
    },
}
