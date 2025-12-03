return {
    "sindrets/diffview.nvim",
    cmd = {
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewLog",
        "DiffviewFocusFiles",
        "DiffviewOpen",
        "DiffviewRefresh",
        "DiffviewToggleFiles",
    },
    keys = {
        { "<leader>gvv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
        { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "Open History" },
        { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>gv", group = "Diffview" },
        })
    end,
    config = function()
        require("diffview").setup({
            keymaps = {
                view = {
                    ["q"] = "<cmd>DiffviewClose<cr>",
                },
                file_panel = {
                    ["q"] = "<cmd>DiffviewClose<cr>",
                },
                file_history_panel = {
                    ["q"] = "<cmd>DiffviewClose<cr>",
                },
            },
        })
    end,
}
