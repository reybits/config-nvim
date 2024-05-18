return {
    -- best git wrapper for vim
    {
        "tpope/vim-fugitive",
        -- stylua: ignore
        cmd = {
            "G", "Git",
            "GBrowse", "GDelete", "GRemove", "GUnlink", "GMove", "GRename",
            "Gcd", "Glcd", "Gclog", "Gllog", "Gdiffsplit", "Gdrop", "Gedit",
            "Ggrep", "Glgrep", "Gpedit", "Gread", "Gtabedit", "Gsplit",
            "Gvdiffsplit", "Gvsplit", "Gwq", "Gwrite"
        },
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "Git Fugitive" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Toggle Git Blame" },
        },
        init = function()
            -- disables legacy commands (like as Gbrowse, Gremove, Grename).
            vim.g.fugitive_legacy_commands = 0
        end,
    },

    -- tig is no longer needed :)
    {
        "rbong/vim-flog",
        cmd = { "Flog", "Flogsplit", "Floggit" },
        keys = {
            { "<leader>gl", "<cmd>Flog<cr>", desc = "A git branch viewer" },
        },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },

    --[[
    -- clone of magit
    "NeogitOrg/neogit",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    opts = {
        graph_style = "unicode",
    },
    -- stylua: ignore
    keys = {
        { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit (cwd)" },
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (project root)" },
    },
    --]]
}
