return {
    "vifm/vifm.vim",
    config = function()
        vim.keymap.set("n", "<leader>e", "<cmd>Vifm<cr>", { desc = "Open Vifm" })
    end,
}
