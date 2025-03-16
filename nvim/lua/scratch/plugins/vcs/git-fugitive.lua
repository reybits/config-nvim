return {
    -- best git wrapper for vim
    "tpope/vim-fugitive",
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
}
