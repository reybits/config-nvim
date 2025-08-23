return {
    -- tig is no longer needed :)
    "rbong/vim-flog",
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
}
