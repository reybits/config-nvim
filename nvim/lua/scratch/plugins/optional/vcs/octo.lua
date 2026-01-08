-- Edit and review GitHub issues and pull requests
-- from the comfort of your favorite editor.
--
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

            picker = "fzf-lua", -- or "telescope", "fzf-lua" or "snacks"
        })
    end,
}
