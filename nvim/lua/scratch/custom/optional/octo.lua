return {
    "pwntester/octo.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "ibhagwan/fzf-lua",
        -- OR 'nvim-telescope/telescope.nvim',
        -- OR 'folke/snacks.nvim',
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "Octo",
    },
    config = function()
        require("octo").setup({
            enable_builtin = true, -- shows a list of builtin actions when no action is provided
            default_merge_method = "commit", -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `commit`, `rebase` or `squash`
            default_delete_branch = false, -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)

            -- when unset, the default vim.ui.select is used.
            -- picker = "fzf-lua", -- or "telescope"
        })
    end,
}
