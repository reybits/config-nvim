return {
    -- best git wrapper for vim
    {
        "tpope/vim-fugitive",
        enabled = false,
        cmd = {
            "G",
            "Git",
            "GBrowse",
            "GDelete",
            "GRemove",
            "GUnlink",
            "GMove",
            "GRename",
            "Gcd",
            "Glcd",
            "Gclog",
            "Gllog",
            "Gdiffsplit",
            "Gdrop",
            "Gedit",
            "Ggrep",
            "Glgrep",
            "Gpedit",
            "Gread",
            "Gtabedit",
            "Gsplit",
            "Gvdiffsplit",
            "Gvsplit",
            "Gwq",
            "Gwrite",
        },
        keys = {
            { "<leader>gf", "<cmd>Git<cr>", desc = "Git Fugitive" },
        },
        init = function()
            -- disables legacy commands (like as Gbrowse, Gremove, Grename).
            vim.g.fugitive_legacy_commands = 0
        end,
    },

    -- vim-fugitive companion
    -- (GBrowse command)
    {
        "tpope/vim-rhubarb",
        enabled = false,
        cmd = {
            "GBrowse",
        },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },

    -- tig is no longer needed :)
    {
        "rbong/vim-flog",
        enabled = false,
        cmd = {
            "Flog",
            "Flogsplit",
            "Floggit",
        },
        keys = {
            { "<leader>gl", "<cmd>Flog<cr>", desc = "A git branch viewer" },
        },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
}
