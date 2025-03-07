return {
    "mbbill/undotree",
    cmd = {
        "UndotreeToggle",
        "UndotreeShow",
        "UndotreeHide",
        "UndotreeFocus",
        "UndotreePersistUndo",
    },
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
    },
    config = function() end,
}
