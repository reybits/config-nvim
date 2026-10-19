return {
    "reybits/scratch.nvim",
    lazy = true,
    keys = {
        { "<leader>tsb", "<cmd>ScratchToggle<cr>", desc = "Toggle Buffer" },
        { "<leader>tsi", "<cmd>ScratchIssues<cr>", desc = "Toggle Issues" },
        { "<leader>tst", "<cmd>ScratchTask<cr>", desc = "Add Task" },
    },
    cmd = {
        "ScratchToggle",
        "ScratchIssues",
        "ScratchTask",
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>ts", group = "Scratch" },
        })
    end,
    opts = {
        width = 0.8,
        height = 0.8,
    },
}
